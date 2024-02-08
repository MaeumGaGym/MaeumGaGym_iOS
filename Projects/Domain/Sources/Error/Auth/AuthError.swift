import Foundation

public enum AuthError: Error {
    case unknown
    case googleSignInFailed
    case appleSignInFailed
    case kakaoSignInFailed
    case tokenNotFound

    var localizedDescription: String {
        switch self {
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        case .googleSignInFailed:
            return "Google 로그인에 실패했습니다."
        case .appleSignInFailed:
            return "Apple 로그인에 실패했습니다."
        case .kakaoSignInFailed:
            return "Kakao 로그인에 실패했습니다."
        case .tokenNotFound:
            return "토큰을 찾을 수 없습니다"
        }
    }
}
