import Foundation
import ProjectDescription
import DependencyPlugin
import EnvPlugin
import ConfigPlugin

public extension Project {
    static func makeModule(
        name: String,
        targets: Set<FeatureTarget> = Set([.staticFramework, .unitTest, .demo]),
        packages: [Package] = [],
        internalDependencies: [TargetDependency] = [],  // 모듈간 의존성
        externalDependencies: [TargetDependency] = [],  // 외부 라이브러리 의존성
        interfaceDependencies: [TargetDependency] = [], // Feature Interface 의존성
        hasResources: Bool = false,
        hasWidget: Bool = false
    ) -> Project {
        
        let configurationName: ConfigurationName = "Development"
        let hasDynamicFramework = targets.contains(.dynamicFramework)
        let deploymentTarget = DeploymentTarget.iOS(targetVersion: "16.0", devices: .iphone)
        let platform = Environment.platform
        
        let baseSettings: SettingsDictionary = .baseSettings.setCodeSignManual()
        
        var projectTargets: [Target] = []
        var schemes: [Scheme] = []
        
        let widget: [Target] = hasWidget ? makeWidgetTarget() : []

        if targets.contains(.app) {
            let bundleSuffix = name.contains("Demo") ? "test" : "release"
            let infoPlist = name.contains("Demo") ? Project.demoInfoPlist : Project.appInfoPlist
            let settings = baseSettings.setProvisioning()
            
            let target = Target(
                name: name,
                platform: platform,
                product: .app,
                bundleId: "\(Environment.bundlePrefix).\(bundleSuffix)",
                deploymentTarget: deploymentTarget,
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["Sources/**/*.swift"],
                resources: [.glob(pattern: "Resources/**", excluding: [])],
                entitlements: .relativeToRoot("Supporting/마음가짐.entitlements"),
                scripts: [.swiftLintScript],
                dependencies: [
                    internalDependencies,
                    externalDependencies
                ].flatMap { $0 },
                settings: .settings(base: settings, configurations: XCConfig.project)
            )
            projectTargets.append(target)
        }
                
        if targets.contains(.interface) {
            let settings = baseSettings
            
            let target = Target(
                name: "\(name)Interface",
                platform: platform,
                product:.framework,
                bundleId: "\(Environment.bundlePrefix).\(name)Interface",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Interface/Sources/**/*.swift"],
                dependencies: interfaceDependencies,
                settings: .settings(base: settings, configurations: XCConfig.framework)
            )
            
            projectTargets.append(target)
        }
                
        if targets.contains(where: { $0.hasFramework }) {
            let deps: [TargetDependency] = targets.contains(.interface)
            ? [.target(name: "\(name)Interface")]
            : []
            let settings = baseSettings
            
            let target = Target(
                name: name,
                platform: platform,
                product: hasDynamicFramework ? .framework : .staticFramework,
                bundleId: "\(Environment.bundlePrefix).\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Sources/**/*.swift"],
                resources: hasResources ? [.glob(pattern: "Resources/**", excluding: [])] : [],
//                entitlements: .relativeToRoot("Supporting/마음가짐.entitlements"),
                dependencies: deps + internalDependencies + externalDependencies,
                settings: .settings(base: settings, configurations: XCConfig.framework)
            )
            
            projectTargets.append(target)
        }
        
        
        if targets.contains(.demo) {

            let deps: [TargetDependency] = [.target(name: name), .Modules.mgFlow]

            var demoInfoPlist = Project.demoInfoPlist

            demoInfoPlist["CFBundleDisplayName"] = "\(name)Demo"
            demoInfoPlist["CFBundleIdentifier"] = "com.maeumGaGym.\(name)Demo"

            let target = Target(
                name: "\(name)Demo",
                platform: platform,
                product: .app,
                bundleId: "com.maeumGaGym.\(name)Demo",
                deploymentTarget: deploymentTarget,
                infoPlist: .extendingDefault(with: demoInfoPlist),
                sources: ["Demo/Sources/**/*.swift"],
                resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
                entitlements: .relativeToRoot("Supporting/마음가짐-Demo.entitlements"),
                scripts: [.swiftLintScript],
                dependencies: [
                    deps
                ].flatMap { $0 },
                settings: .settings(base: baseSettings, configurations: XCConfig.demo)
            )

            projectTargets.append(target)
        }
        
        if targets.contains(.unitTest) {
            let deps: [TargetDependency] = [.target(name: name)]
            
            let target = Target(
                name: "\(name)Tests",
                platform: platform,
                product: .unitTests,
                bundleId: "\(Environment.bundlePrefix).\(name)Tests",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Tests/Sources/**/*.swift"],
                resources: [.glob(pattern: "Tests/Resources/**", excluding: [])],
                scripts: [.swiftLintScript],
                dependencies: [
                    deps,
                    [
                        .Modules.testCore
                    ]
                ].flatMap { $0 },
                settings: .settings(base: SettingsDictionary().setCodeSignManual(), configurations: XCConfig.tests)
            )
            
            projectTargets.append(target)
            projectTargets += widget
        }
        
        
        if targets.contains(.uiTest) {
            let deps: [TargetDependency] = targets.contains(.demo)
            ? [.target(name: name), .target(name: "\(name)Demo")] : [.target(name: name)]
            
            let target = Target(
                name: "\(name)UITests",
                platform: platform,
                product: .uiTests,
                bundleId: "\(Environment.bundlePrefix).\(name)UITests",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["UITests/Sources/**/*.swift"],
                scripts: [.swiftLintScript],
                dependencies: [
                    deps,
                    [
                        .Modules.testCore
                    ]
                ].flatMap { $0 },
                settings: .settings(base: SettingsDictionary().setCodeSignManual(), configurations: XCConfig.tests)
            )
            
            projectTargets.append(target)
        }
        
        // MARK: - Schemes
        
        let additionalSchemes = targets.contains(.demo)
        ? [Scheme.makeScheme(configs: configurationName, name: name),
           Scheme.makeDemoScheme(configs: configurationName, name: name)]
        : [Scheme.makeScheme(configs: configurationName, name: name)]
        schemes += additionalSchemes
        
        var scheme = targets.contains(.app)
        ? appSchemes
        : schemes
        
        if name.contains("Demo") {
            let testAppScheme = Scheme.makeScheme(configs: "QA", name: name)
            scheme.append(testAppScheme)
        }
        
        return Project(
            name: name,
            organizationName: Environment.workspaceName,
            packages: packages,
            settings: .settings(base: Environment.baseSetting.merging(.codeSign),configurations: XCConfig.project),
            targets: projectTargets,
            schemes: scheme
        )
    }
    
    static func makeSettingDictionary()-> SettingsDictionary {
        return SettingsDictionary()
            .automaticCodeSigning(devTeam: "92YDTRVDUA")
            .merging(["VERSIONING_SYSTEM": "apple-generic",
                      "BUILD_LIBRARY_FOR_DISTRIBUTION": "NO"])
    }
    
    static func makeWidgetTarget()-> [Target] {
        return [Target(name: "WidgetExtension",
                       platform: .iOS,
                       product: .appExtension,
                       bundleId: Environment.bundlePrefix + ".WidgetExtension",
                       deploymentTarget: Environment.deploymentTarget,
                       infoPlist: .file(path: .relativeToRoot("WidgetExtension/Info.plist")),
                       sources: [.glob(.relativeToRoot("WidgetExtension/**"))],
                       resources: [.glob(pattern: .relativeToRoot("WidgetExtension/Resources/**"))],
                       entitlements: .relativeToRoot("Supporting/WidgetExtension.entitlements"),
                       dependencies: [.Modules.dsKit, .data, .domain],
                       settings: .settings(configurations: [
                        .debug(name: .debug, settings: makeSettingDictionary().merging(["MTL_ENABLE_DEBUG_INFO": "INCLUDE_SOURCE"])),
                        .release(name: .release, settings: makeSettingDictionary().merging(["MTL_ENABLE_DEBUG_INFO": "NO"]))
                       ]))]
    }
}

extension Scheme {
    /// Scheme 생성하는 method
    static func makeScheme(configs: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: configs,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: configs),
            archiveAction: .archiveAction(configuration: configs),
            profileAction: .profileAction(configuration: configs),
            analyzeAction: .analyzeAction(configuration: configs)
        )
    }
    
    static func makeDemoScheme(configs: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: "\(name)Demo",
            shared: true,
            buildAction: .buildAction(targets: ["\(name)Demo"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: configs,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)Demo"])
            ),
            runAction: .runAction(configuration: configs),
            archiveAction: .archiveAction(configuration: configs),
            profileAction: .profileAction(configuration: configs),
            analyzeAction: .analyzeAction(configuration: configs)
        )
    }
    
    static func makeDemoAppTestScheme() -> Scheme {
        let targetName = "\(Environment.workspaceName)-Demo"
        return Scheme(
          name: "\(targetName)-Test",
          shared: true,
          buildAction: .buildAction(targets: ["\(targetName)"]),
          testAction: .targets(
              ["\(targetName)Tests"],
              configuration: "Test",
              options: .options(coverage: true, codeCoverageTargets: ["\(targetName)"])
          ),
          runAction: .runAction(configuration: "Test"),
          archiveAction: .archiveAction(configuration: "Test"),
          profileAction: .profileAction(configuration: "Test"),
          analyzeAction: .analyzeAction(configuration: "Test")
        )
    }
}

extension Project {
    static let appSchemes: [Scheme] = [
        .init(
            name: "\(Environment.workspaceName)-DEV",
            shared: true,
            buildAction: .buildAction(targets: ["\(Environment.workspaceName)"]),
            testAction: .targets(
                ["\(Environment.workspaceName)Tests", "\(Environment.workspaceName)UITests"],
                configuration: "Development",
                options: .options(coverage: true, codeCoverageTargets: ["\(Environment.workspaceName)"])
            ),
            runAction: .runAction(configuration: "Development"),
            archiveAction: .archiveAction(configuration: "Development"),
            profileAction: .profileAction(configuration: "Development"),
            analyzeAction: .analyzeAction(configuration: "Development")
        ),
        .init(
            name: "\(Environment.workspaceName)-Test",
            shared: true,
            buildAction: .buildAction(targets: ["\(Environment.workspaceName)"]),
            testAction: .targets(
                ["\(Environment.workspaceName)Tests", "\(Environment.workspaceName)UITests"],
                configuration: "Test",
                options: .options(coverage: true, codeCoverageTargets: ["\(Environment.workspaceName)"])
            ),
            runAction: .runAction(configuration: "Test"),
            archiveAction: .archiveAction(configuration: "Test"),
            profileAction: .profileAction(configuration: "Test"),
            analyzeAction: .analyzeAction(configuration: "Test")
        ),
        .init(
            name: "\(Environment.workspaceName)-QA",
            shared: true,
            buildAction: .buildAction(targets: ["\(Environment.workspaceName)"]),
            runAction: .runAction(configuration: "QA"),
            archiveAction: .archiveAction(configuration: "QA"),
            profileAction: .profileAction(configuration: "QA"),
            analyzeAction: .analyzeAction(configuration: "QA")
        ),
        .init(
            name: "\(Environment.workspaceName)-PROD",
            shared: true,
            buildAction: .buildAction(targets: ["\(Environment.workspaceName)"]),
            runAction: .runAction(configuration: "PROD"),
            archiveAction: .archiveAction(configuration: "PROD"),
            profileAction: .profileAction(configuration: "PROD"),
            analyzeAction: .analyzeAction(configuration: "PROD")
        ),
        .makeDemoAppTestScheme()
    ]
}
