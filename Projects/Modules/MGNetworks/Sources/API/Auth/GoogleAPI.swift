import Foundation

import Moya
import Core
import Alamofire

public enum GoogleAPI {
    case googleSignup(nickname: String, accessToken: String)
    case googleLogin(accessToken: String)
    case googleRecovery(accessToken: String)
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
        case let .googleSignup(nickname, accessToken):
            let bodyParameters: [String: Any] = [
                "nickname": nickname
            ]
            let urlParameters: [String: Any] = [
                "access_token": accessToken
            ]
            return .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: urlParameters)
        case let .googleLogin(accessToken):
            let parameters: [String: Any] = [
                "access_token": accessToken
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .googleRecovery(accessToken):
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
