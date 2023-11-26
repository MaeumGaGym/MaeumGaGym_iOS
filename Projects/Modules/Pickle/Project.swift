import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Pickle",
    targets: [.unitTest, .demo, .dynamicFramework],
    internalDependencies: [
        .core
    ]
)
