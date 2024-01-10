import Foundation
import UIKit

public enum TextFieldErrorType {
    
    public enum Name {
        case tooLong // 이름이 너무 길어요 (16글자 이하)
        case tooShort // 이름이 너무 짧아요 (2글자 이상)
        case alreadyTaken // 이름이 이미 사용 중 입니다.
        case sensitiveInfo // 이름에 민감한 정보 포함
        case reservedWord // 예약어 사용 제한
        
        public var message: String {
            switch self {
            case .tooLong:
                return "너무 긴 닉네임이에요. (10글자 이하)"
            case .tooShort:
                return "너무 짧은 닉네임이에요. (2글자 이상)"
            case .alreadyTaken:
                return "이미 사용중인 닉네임이에요."
            case .sensitiveInfo:
                return "민감한 정보가 포함된 닉네임이에요."
            case .reservedWord:
                return "예약어 사용 제한"
            }
        }
        public var showError: Bool {
            return true
        }
    }
}
