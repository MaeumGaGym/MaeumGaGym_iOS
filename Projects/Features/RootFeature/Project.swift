import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "RootFeature",
    targets: [.unitTest, .staticFramework, .demo],
    internalDependencies: [
        .Modules.mgFlow
    ]
)
