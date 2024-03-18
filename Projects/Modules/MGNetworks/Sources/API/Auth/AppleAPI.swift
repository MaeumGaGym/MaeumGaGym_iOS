import Foundation

import Moya
import Core
import Alamofire

public enum AppleAPI {
    case appleSignup(nickname: String, accessToken: String)
    case appleLogin(accessToken: String)
    case appleRecovery(accessToken: String)
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
        case let .appleSignup(nickname, accessToken):
            let parameters: [String: Any] = [
                "nickname": nickname,
                "access_token": accessToken
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .appleLogin(accessToken):
            let parameters: [String: Any] = [
                "access_token": accessToken
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .appleRecovery(accessToken):
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
