import UIKit
import RxSwift
import RxCocoa
import MGLogger
import Core

public enum MGPreparingType: String {
    case pickle = "Pickle"
    case shop = "Shop"

    func title() -> String {
        switch self {
        case .pickle:
            return "피클은 아직 개발중이에요"
        case .shop:
            return "샵은 아직 개발중이에요"
        }
    }

    func info() -> String {
        switch self {
        case .pickle:
            return "피클 탭은 개발중입니다.\n빠른 시일 내에 더욱 나은 모습으로 찾아뵙겠습니다."
        case .shop:
            return "샵 탭은 개발중입니다.\n빠른 시일 내에 더욱 나은 모습으로 찾아뵙겠습니다."
        }
    }
}
