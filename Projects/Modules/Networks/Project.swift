import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Networks",
    targets: [.unitTest, .staticFramework],
    internalDependencies: [
        .core
    ]
)
