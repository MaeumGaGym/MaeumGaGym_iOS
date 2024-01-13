import Foundation
import ProjectDescription
import DependencyPlugin
import EnvPlugin

public extension Project {
    static func makeModule(
        name: String,
        targets: Set<FeatureTarget> = Set([.staticFramework, .unitTest, .demo]),
        packages: [Package] = [],
        internalDependencies: [TargetDependency] = [],  // 모듈간 의존성
        externalDependencies: [TargetDependency] = [],  // 외부 라이브러리 의존성
        interfaceDependencies: [TargetDependency] = [], // Feature Interface 의존성
        hasResources: Bool = false
    ) -> Project {
        
        let hasDynamicFramework = targets.contains(.dynamicFramework)
        let deploymentTarget = Environment.deploymentTarget
        let platform = Environment.platform
        
        let baseSettings: SettingsDictionary = .baseSettings.setCodeSignManual()
        
        var projectTargets: [Target] = []
                
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
                scripts: [.swiftLintScript],
                dependencies: [
                    internalDependencies,
                    externalDependencies
                ].flatMap { $0 },
                settings: .settings(base: settings)
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
                settings: .settings(base: settings)
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
                dependencies: deps + internalDependencies + externalDependencies,
                settings: .settings(base: settings)
            )
            
            projectTargets.append(target)
        }
        
        
        if targets.contains(.demo) {
            let deps: [TargetDependency] = [.target(name: name)]

            var demoInfoPlist = Project.demoInfoPlist

            demoInfoPlist["CFBundleDisplayName"] = "\(name)-Demo"
            demoInfoPlist["CFBundleIdentifier"] = "com.maeumGaGym-\(name)-iOS.test"

            let target = Target(
                name: "\(name)Demo",
                platform: platform,
                product: .app,
                bundleId: "\(Environment.bundlePrefix).\(name)Demo",
                deploymentTarget: deploymentTarget,
                infoPlist: .extendingDefault(with: demoInfoPlist),
                sources: ["Demo/Sources/**/*.swift"],
                resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
                scripts: [.swiftLintScript],
                dependencies: [
                    deps
                ].flatMap { $0 },
                settings: .settings(base: baseSettings)
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
                settings: .settings(base: SettingsDictionary().setCodeSignManual())
            )
            
            projectTargets.append(target)
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
                settings: .settings(base: SettingsDictionary().setCodeSignManual())
            )
            
            projectTargets.append(target)
        }
                                
        return Project(
            name: name,
            organizationName: Environment.workspaceName,
            packages: packages,
            targets: projectTargets
        )
    }
}

//
//extension Scheme {
//    /// Scheme 생성하는 method
//    static func makeScheme(configs: ConfigurationName, name: String) -> Scheme {
//        return Scheme(
//            name: name,
//            shared: true,
//            buildAction: .buildAction(targets: ["\(name)"]),
//            testAction: .targets(
//                ["\(name)Tests"],
//                configuration: configs,
//                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
//            ),
//            runAction: .runAction(configuration: configs),
//            archiveAction: .archiveAction(configuration: configs),
//            profileAction: .profileAction(configuration: configs),
//            analyzeAction: .analyzeAction(configuration: configs)
//        )
//    }
//    
//    static func makeDemoScheme(configs: ConfigurationName, name: String) -> Scheme {
//        return Scheme(
//            name: "\(name)Demo",
//            shared: true,
//            buildAction: .buildAction(targets: ["\(name)Demo"]),
//            testAction: .targets(
//                ["\(name)Tests"],
//                configuration: configs,
//                options: .options(coverage: true, codeCoverageTargets: ["\(name)Demo"])
//            ),
//            runAction: .runAction(configuration: configs),
//            archiveAction: .archiveAction(configuration: configs),
//            profileAction: .profileAction(configuration: configs),
//            analyzeAction: .analyzeAction(configuration: configs)
//        )
//    }
//}
