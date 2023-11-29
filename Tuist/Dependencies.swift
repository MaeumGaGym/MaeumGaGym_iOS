import ProjectDescription
import ProjectDescriptionHelpers

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.6.0")),
    .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2")),
    .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from: "6.5.0")),
    .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.8.0")),
    .remote(url: "https://github.com/RxSwiftCommunity/RxFlow.git", requirement: .upToNextMajor(from: "2.10.0"))
])

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
