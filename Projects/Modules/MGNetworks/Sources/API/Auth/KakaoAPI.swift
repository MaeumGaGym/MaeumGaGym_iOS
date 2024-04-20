import Foundation

import Moya
import Core
import Alamofire

import Domain

public enum KakaoAPI {
    case kakaoSignup(param: SignupRequestDTO)
    case kakaoLogin(param: LoginRequestDTO)
    case kakaoRecovery(param: RecoveryRequestDTO)
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
        case .kakaoSignup(let param):
            let bodyParameters: [String: Any] = [
                "nickname": param.nickname
            ]
            return .requestParameters(parameters: bodyParameters, encoding: JSONEncoding.default)
        case .kakaoLogin, .kakaoRecovery:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .kakaoSignup(let param):
            return ["OAUTH-TOKEN": "\(param.oauthToken)"]
        case .kakaoLogin(let param):
            return ["OAUTH-TOKEN": "\(param.oauthToken)"]
        case .kakaoRecovery(let param):
            return ["OAUTH-TOKEN": "\(param.oauthToken)"]
        }
    }
}
