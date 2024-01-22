import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "SelfCareFeature",
    targets: [.unitTest, .staticFramework, .demo, .interface],
    internalDependencies: [
        .Modules.mgCameraKit
    ],
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ]
)
