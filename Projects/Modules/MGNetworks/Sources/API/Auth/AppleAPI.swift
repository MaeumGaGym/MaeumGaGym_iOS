import Foundation

import Moya
import Core
import Alamofire

public enum AppleAPI {
    case appleSignup(nickname: String, oauthToken: String)
    case appleLogin(oauthToken: String)
    case appleRecovery(oauthToken: String)
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
        case let .appleSignup(nickname, _):
            let bodyParameters: [String: Any] = [
                "nickname": nickname
            ]
            return .requestParameters(parameters: bodyParameters, encoding: JSONEncoding.default)
        case .appleLogin, .appleRecovery:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case let .appleSignup(_, oauthToken):
            return ["OAUTH-TOKEN": "\(oauthToken)"]
        case let .appleLogin(oauthToken):
            return ["OAUTH-TOKEN": "\(oauthToken)"]
        case let .appleRecovery(oauthToken):
            return ["OAUTH-TOKEN": "\(oauthToken)"]
        }
    }
}
