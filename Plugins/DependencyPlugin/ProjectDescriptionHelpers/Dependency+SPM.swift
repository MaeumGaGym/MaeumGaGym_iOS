import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let RxSwift = TargetDependency.external(name: "RxSwift")
    static let RxCocoa = TargetDependency.external(name: "RxCocoa")
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let Then = TargetDependency.external(name: "Then")
    static let RxFlow = TargetDependency.external(name: "RxFlow")
    static let RxTest = TargetDependency.external(name: "RxTest")
    static let RxBlocking = TargetDependency.external(name: "RxBlocking")
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let Moya = TargetDependency.external(name: "Moya")
    static let RxMoya = TargetDependency.external(name: "RxMoya")
    static let Lottie = TargetDependency.external(name: "Lottie")
    static let kingfisher = TargetDependency.external(name: "Kingfisher")
    static let MindGymKit = TargetDependency.external(name: "MindGymKit")
    static let KakaoSDK = TargetDependency.external(name: "KakaoSDK")
    static let Mango = TargetDependency.external(name: "Mango")
    static let SnapshotTesting = TargetDependency.external(name: "SnapshotTesting")
    static let GoogleSignIn = TargetDependency.external(name: "GoogleSignIn")
}

