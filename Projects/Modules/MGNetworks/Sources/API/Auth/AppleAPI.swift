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
            let bodyParameters: [String: Any] = [
                "nickname": nickname
            ]
            let urlParameters: [String: Any] = [
                "access_token": accessToken
            ]
            return .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: urlParameters)
        case let .appleLogin(accessToken):
            let parameters: [String: Any] = [
                "access_token": accessToken
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .appleRecovery(accessToken):
            let parameters: [String: Any] = [
                "access_token": accessToken
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String : String]? {
        return nil
    }
}
