import Foundation

import Alamofire
import Moya
import Core

import TokenManager

public enum GoogleAPI {
    case googleLogin
    case googleSignup(nickname: String, accessToken: String)
    case googleRecovery
}

extension GoogleAPI: BaseAPI {

    public static var apiType: APIType = .google

    public var path: String {
        switch self {
        case .googleLogin:
            return "/login"
        case .googleSignup:
            return "/signup"
        case .googleRecovery:
            return "/recovery"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .googleLogin:
            return .get
        case .googleSignup:
            return .post
        case .googleRecovery:
            return .put
        }
    }

    public var task: Moya.Task {
        switch self {
        case let .googleSignup(nickname, accessToken):
            let parameters: [String: Any] = [
                "nickname": nickname,
                "access_token": accessToken
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .googleLogin, .googleRecovery:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        return nil
    }
}
