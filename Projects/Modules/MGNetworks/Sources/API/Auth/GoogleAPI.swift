import Foundation

import Moya
import Core
import Alamofire

import Domain

public enum GoogleAPI {
    case googleSignup(param: SignupRequestDTO)
    case googleLogin(param: LoginRequestDTO)
    case googleRecovery(param: RecoveryRequestDTO)
}

extension GoogleAPI: BaseAPI {

    public static var apiType: APIType = .google

    public var path: String {
        switch self {
        case .googleSignup:
            return "/signup"
        case .googleLogin:
            return "/login"
        case .googleRecovery:
            return "/recovery"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .googleSignup:
            return .post
        case .googleLogin:
            return .get
        case .googleRecovery:
            return .put
        }
    }

    public var task: Moya.Task {
        switch self {
        case .googleSignup(let param):
            let bodyParameters: [String: Any] = [
                "nickname": param.nickname
            ]
            return .requestParameters(parameters: bodyParameters, encoding: JSONEncoding.default)
        case .googleLogin, .googleRecovery:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .googleSignup(let param):
            return ["OAUTH-TOKEN": "\(param.oauthToken)"]
        case .googleLogin(let param):
            return ["OAUTH-TOKEN": "\(param.oauthToken)"]
        case .googleRecovery(let param):
            return ["OAUTH-TOKEN": "\(param.oauthToken)"]
        }
    }
}
