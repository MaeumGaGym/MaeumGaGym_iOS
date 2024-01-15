import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "DSKit",
    targets: [.unitTest, .demo, .dynamicFramework],
    internalDependencies: [
        .core,
        .Modules.mgLogger
    ],
    hasResources: true
)
