import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "ThirdPartyLibs",
    targets: [.dynamicFramework],
    externalDependencies: [
        .SPM.RxCocoa,
        .SPM.RxFlow,
        .SPM.RxSwift,
        .SPM.SnapKit,
        .SPM.Then,
        .SPM.Swinject,
        .SPM.GoogleLogin,
        .SPM.Moya,
        .SPM.RxMoya,
        .SPM.Lottie,
        .SPM.kingfisher,
        .SPM.KakaoSDK,
        .SPM.MindGymKit
    ]
)
