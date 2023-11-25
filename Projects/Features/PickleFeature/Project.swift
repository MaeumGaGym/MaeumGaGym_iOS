import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "PickleFeature",
    targets: [.unitTest, .staticFramework, .demo, .interface],
    internalDependencies: [
        .Modules.pickle
    ],
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ]
)
