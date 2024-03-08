import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "TestCore",
    targets: [.dynamicFramework],
    internalDependencies: [
        .core,
        .SPM.Mango,
        .SPM.SnapshotTesting,
        .SPM.RxBlocking,
        .SPM.RxTest,
        .sdk(name: "XCTest", type: .framework, status: .required)
    ]
)
