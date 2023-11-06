import ProjectDescription
import ProjectDescriptionHelpers

let spm = SwiftPackageManagerDependencies(
    [
        .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from:"6.0.0")),
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.6.0")),
        .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "3.0.0")),

    ],
    productTypes: [
        "RxSwift": .framework,
        "RxCocoa": .framework,
        "RxRelay": .framework,
        "SnapKit": .framework,
        "Then": .framework
    ]
)

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
