import ProjectDescription
import ProjectDescriptionHelpers

let spm = SwiftPackageManagerDependencies(
    [
        .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from:"6.0.0"))
    ],
    productTypes: [
        "RxSwift": .framework,
        "RxCocoa": .framework,
        "RxRelay": .framework
    ]
)

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
