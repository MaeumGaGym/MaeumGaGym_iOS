import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "MGCameraKit",
    targets: [.unitTest, .demo, .dynamicFramework],
    internalDependencies: [
        .core
    ]
)
