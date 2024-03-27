import UIKit
import Foundation

public enum agreeButtonTextType {
    case allAgreeText
    case privacyAgreeText
    case termsAgreeText
    case ageAgreeText
    case marketingAgreeText
    
    var message: String {
        switch self {
        case .privacyAgreeText:
            return "개인정보 수집 이용 동의"
        case .termsAgreeText:
            return "이용 약관 동의"
        case .ageAgreeText:
            return "만 14세 이상"
        case .marketingAgreeText:
            return "마케팅 정보 수신 동의"
        case .allAgreeText:
            return "모두 동의해요"
        }
    }

    var font: UIFont {
        switch self {
        case .privacyAgreeText:
            return UIFont.Pretendard.bodyMedium
        case .termsAgreeText:
            return UIFont.Pretendard.bodyMedium
        case .ageAgreeText:
            return UIFont.Pretendard.bodyMedium
        case .marketingAgreeText:
            return UIFont.Pretendard.bodyMedium
        case .allAgreeText:
            return UIFont.Pretendard.labelLarge
        }
    }
}
