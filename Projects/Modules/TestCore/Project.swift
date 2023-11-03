import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "TestCore",
    targets: [.dynamicFramework],
    internalDependencies: [
        .core,
        .sdk(name: "XCTest", type: .framework, status: .required)
    ]
)
