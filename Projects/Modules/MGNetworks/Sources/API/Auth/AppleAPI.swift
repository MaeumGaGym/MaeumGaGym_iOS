import Foundation

import Moya
import Core
import Alamofire

import Domain

public enum AppleAPI {
    case appleSignup(param: SignupRequestDTO)
    case appleLogin(param: LoginRequestDTO)
    case appleRecovery(param: RecoveryRequestDTO)
}

extension AppleAPI: BaseAPI {

    public static var apiType: APIType = .apple

    public var path: String {
        switch self {
        case .appleSignup:
            return "/signup"
        case .appleLogin:
            return "/login"
        case .appleRecovery:
            return "/recovery"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .appleSignup:
            return .post
        case .appleLogin:
            return .get
        case .appleRecovery:
            return .put
        }
    }

    public var task: Moya.Task {
        switch self {
        case .appleSignup(let param):
            let bodyParameters: [String: Any] = [
                "nickname": param.nickname
            ]
            return .requestParameters(parameters: bodyParameters, encoding: JSONEncoding.default)
        case .appleLogin, .appleRecovery:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .appleSignup(let param):
            return ["OAUTH-TOKEN": "\(param.oauthToken)"]
        case .appleLogin(let param):
            return ["OAUTH-TOKEN": "\(param.oauthToken)"]
        case .appleRecovery(let param):
            return ["OAUTH-TOKEN": "\(param.oauthToken)"]
        }
    }
}
