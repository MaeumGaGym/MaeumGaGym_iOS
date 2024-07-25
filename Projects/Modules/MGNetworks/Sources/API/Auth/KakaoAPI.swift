import Foundation

import Moya
import Core
import Alamofire

public enum KakaoAPI {
    case kakaoSignup(nickname: String, oauthToken: String)
    case kakaoLogin(oauthToken: String)
    case kakaoRecovery(oauthToken: String)
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
        case let .kakaoSignup(nickname, _):
            let bodyParameters: [String: Any] = [
                "nickname": nickname
            ]
            return .requestParameters(parameters: bodyParameters, encoding: JSONEncoding.default)
        case .kakaoLogin, .kakaoRecovery:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case let .kakaoSignup(_, oauthToken):
            return ["OAUTH-TOKEN": "\(oauthToken)"]
        case let .kakaoLogin(oauthToken):
            return ["OAUTH-TOKEN": "\(oauthToken)"]
        case let .kakaoRecovery(oauthToken):
            return ["OAUTH-TOKEN": "\(oauthToken)"]
        }
    }
}
