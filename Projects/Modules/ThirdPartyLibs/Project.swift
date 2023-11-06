import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "ThirdPartyLibs",
    targets: [.dynamicFramework],
    externalDependencies: [
        .SPM.RxCocoa,
        .SPM.RxSwift,
        .SPM.RxRelay,
        .SPM.SnapKit,
        .SPM.Then,
        .SPM.Swinject,
        .SPM.RxFlow
    ]
)
