import ProjectDescription
import ProjectDescriptionHelpers

let spm = SwiftPackageManagerDependencies([
//    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.6.0")),
//    .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.0")),
//    .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "3.0.0")),
//    .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.10.0")),
//    .remote(url: "https://github.com/airbnb/lottie-ios", requirement: .upToNextMajor(from: "4.3.3")),
], baseSettings: Settings.settings(

))

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
