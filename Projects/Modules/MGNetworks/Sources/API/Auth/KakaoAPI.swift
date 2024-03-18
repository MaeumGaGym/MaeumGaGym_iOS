import Foundation

import Moya
import Core
import Alamofire

public enum KakaoAPI {
    case kakaoSignup(nickname: String, accessToken: String)
    case kakaoLogin(accessToken: String)
    case kakaoRecovery(accessToken: String)
}

extension KakaoAPI: BaseAPI {

    public static var apiType: APIType = .kakao

    public var path: String {
        switch self {
        case .kakaoSignup:
            return "/signup"
        case .kakaoLogin:
            return "/login"
        case .kakaoRecovery:
            return "/recovery"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .kakaoSignup:
            return .post
        case .kakaoLogin:
            return .get
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
        case let .kakaoLogin(accessToken):
            let parameters: [String: Any] = [
                "access_token": accessToken
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .kakaoRecovery(accessToken):
            let parameters: [String: Any] = [
                "access_token": accessToken
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }

    public var headers: [String : String]? {
        return nil
    }
}
