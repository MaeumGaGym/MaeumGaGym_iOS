import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "MGNetworks",
    targets: [.unitTest, .staticFramework],
    internalDependencies: [
//        .core,
        .Modules.tokenManager,
        .Modules.dsKit
    ]
)
