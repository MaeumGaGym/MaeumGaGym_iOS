import Foundation
import UIKit

public enum TextFieldErrorType {
    public enum Email {
        case notExist // 이메일이 존재하지 않습니다
        case formatIncorrect // 이메일 형식이 올바르지 않습니다
        case alreadyUse // 이미 사용 중인 이메일입니다
        case network // 네트워크 연결 오류
        case enteredValueExceeded // 입력한 값의 길이를 초과했습니다
        
        var message: String {
            switch self {
            case .notExist:
                return "이메일이 존재하지 않습니다"
            case .formatIncorrect:
                return "이메일 형식이 올바르지 않습니다"
            case .alreadyUse:
                return "이미 사용 중인 이메일입니다"
            case .network:
                return "네트워크 연결 오류"
            case .enteredValueExceeded:
                return "입력한 값의 길이를 초과했습니다"
            }
        }
        var showError: Bool {
            return true
        }
    }
    
    public enum Password {
        case notMatch // 비밀번호가 일치하지 않습니다
        case weakPassword // 비밀번호가 너무 약합니다
        case resetTime // 비밀번호 재설정 시간 제한
        case expiration // 비밀번호 유효기간 만료
        case limitOld // 이전 비밀번호 재사용 제한
        
        var message: String {
            switch self {
            case .notMatch:
                return "비밀번호가 일치하지 않습니다"
            case .weakPassword:
                return "비밀번호가 너무 약합니다"
            case .resetTime:
                return "비밀번호 재설정 시간 제한"
            case .expiration:
                return "비밀번호 유효기간 만료"
            case .limitOld:
                return "이전 비밀번호 재사용 제한"
            }
        }
        var showError: Bool {
            return true
        }
    }
    
    public enum Code {
        case invalid // 유효하지 않은 인증 코드
        case expiration // 인증 코드 만료
        case resendRestrictions // 인증 코드 재전송 제한
        case format // 인증 코드 형식 오류
        
        var message: String {
            switch self {
            case .invalid:
                return "유효하지 않은 인증 코드"
            case .expiration:
                return "인증 코드 만료"
            case .resendRestrictions:
                return "인증 코드 재전송 제한"
            case .format:
                return "인증 코드 형식 오류"
            }
        }
        var showError: Bool {
            return true
        }
    }
    
    public enum Name {
        case tooLong // 이름이 너무 길어요 (16글자 이하)
        case tooShort // 이름이 너무 짧아요 (2글자 이상)
        case alreadyTaken // 이름이 이미 사용 중 입니다.
        case sensitiveInfo // 이름에 민감한 정보 포함
        case reservedWord // 예약어 사용 제한
        
        var message: String {
            switch self {
            case .tooLong:
                return "이름이 너무 길어요 (16글자 이하)"
            case .tooShort:
                return "이름이 너무 짧아요 (2글자 이상)"
            case .alreadyTaken:
                return "이름이 이미 사용 중 입니다."
            case .sensitiveInfo:
                return "이름에 민감한 정보 포함"
            case .reservedWord:
                return "예약어 사용 제한"
            }
        }
        var showError: Bool {
            return true
        }
    }
    
    public enum ID {
        case invalidFormat // 유효하지 않은 아이디 형식
        case lengthLimit(minimum: Int) // 아이디는 최소한 4글자 이상이어야 합니다.
        case alreadyTaken // 이미 사용중인 아이디입니다. 다른 아이디를 선택해주세요
        case sensitiveInfo // 아이디에 민감한 정보 포함 제한
        
        var message: String {
            switch self {
            case .invalidFormat:
                return "유효하지 않은 아이디 형식"
            case .lengthLimit(minimum: let minimum):
                return "아이디는 최소한 \(minimum)글자 이상이어야 합니다."
            case .alreadyTaken:
                return "이미 사용중인 아이디입니다. 다른 아이디를 선택해주세요"
            case .sensitiveInfo:
                return "아이디에 민감한 정보 포함 제한"
            }
        }
        var showError: Bool {
            return true
        }
    }
    
    public enum Age {
        case unreasonableAge // 나이가 너무 말도 안되게 많습니다.
        case ageFormatError // 나이는 숫자로만 입력할 수 있습니다.
        
        var message: String {
            switch self {
            case .unreasonableAge:
                return "나이가 너무 말도 안되게 많습니다."
            case .ageFormatError:
                return "나이는 숫자로만 입력할 수 있습니다."
            }
        }
        var showError: Bool {
            return true
        }
    }
    
    public enum Height {
        case heightFormatError // 키는 숫자로만 입력할 수 있습니다.
        
        var message: String {
            switch self {
            case .heightFormatError:
                return "나이가 너무 말도 안되게 많습니다."
            }
        }
        var showError: Bool {
            return true
        }
    }
    
    public enum Weight {
        case weightFormatError // 몸무게는 숫자로만 입력할 수 있습니다.
        
        var message: String {
            switch self {
            case .weightFormatError:
                return "몸무게는 숫자로만 입력할 수 있습니다."
            }
        }
        
        var showError: Bool {
            return true
        }
    }
}
