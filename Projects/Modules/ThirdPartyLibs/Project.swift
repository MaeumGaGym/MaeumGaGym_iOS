import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "ThirdPartyLibs",
    targets: [.dynamicFramework],
    externalDependencies: [
//        .SPM.SnapKit,
//        .SPM.Kingfisher,
//        .SPM.Then,
//        .SPM.lottie
    ]
)
