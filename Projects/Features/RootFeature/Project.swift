import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "RootFeature",
    targets: [.unitTest, .staticFramework, .demo],
    internalDependencies: [
        .Features.Home.Feature,
        .Features.Auth.Feature,
        .Features.Posture.Feature,
        .Features.SelfCare.Feature,
        .Features.Shop.Feature,
        .Features.Pickle.Feature,
        .data
    ]
)
