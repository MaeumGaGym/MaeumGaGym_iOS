import Foundation

import Alamofire
import Moya
import Core

import TokenManager

public enum AppleAPI {
    case appleLogin
    case appleSignup(nickname: String, accessToken: String)
    case appleRecovery
}

extension AppleAPI: BaseAPI {

    public static var apiType: APIType = .apple

    public var path: String {
        switch self {
        case .appleLogin:
            return "/login"
        case .appleSignup:
            return "/signup"
        case .appleRecovery:
            return "/recovery"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .appleLogin:
            return .get
        case .appleSignup:
            return .post
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
        case .appleLogin, .appleRecovery:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        return nil
    }
}
