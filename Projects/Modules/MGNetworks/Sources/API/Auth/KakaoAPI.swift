import Foundation

import Alamofire
import Moya
import Core

import TokenManager

public enum KakaoAPI {
    case kakaoLogin
    case kakaoSignup(nickname: String, accessToken: String)
    case kakaoRecovery
}

extension KakaoAPI: BaseAPI {
    
    public static var apiType: APIType = .kakao

    public var path: String {
        switch self {
        case .kakaoLogin:
            return "/login"
        case .kakaoSignup:
            return "/signup"
        case .kakaoRecovery:
            return "/recovery"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .kakaoLogin:
            return .get
        case .kakaoSignup:
            return .post
        case .kakaoRecovery:
            return .put
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .kakaoSignup(nickname, accessToken):
            let parameters: [String: Any] = [
                "nickname": nickname,
                "access_token": accessToken
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .kakaoLogin, .kakaoRecovery:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .kakaoSignup:
            if let csrfToken = TokenManagerImpl().get(key: .CSRFToken) {
                return [
                    "X-XSRF-TOKEN": csrfToken
                ]
            } else {
                return nil
            }
        case .kakaoLogin, .kakaoRecovery:
            return nil
        }
    }
    
}
