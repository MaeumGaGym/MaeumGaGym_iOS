import Foundation
import ProjectDescription

public enum FeatureTarget {
    case app    // 배포용 앱일 때 사용합니다.
    case interface  // Feature Interface가 필요한 feature를 사용하기 위해 사용합니다.
    case dynamicFramework
    case staticFramework
    case unitTest   // Unit Test를 할 때 사용합니다.
    case uiTest // UI Test를 할 때 사용합니다.
    case demo   // Feature를 데모 테스트를 할 떄 사용합니다.

    public var hasFramework: Bool {
        switch self {
        case .dynamicFramework, .staticFramework: return true
        default: return false
        }
    }
    public var hasDynamicFramework: Bool { return self == .dynamicFramework }
}
