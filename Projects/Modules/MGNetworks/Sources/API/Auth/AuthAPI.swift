import Foundation

import Moya
import Core
import Alamofire

public enum AuthAPI {
    case delete(accessToken: String)
    case reissuanceToken(refreshToken: String)
    case nickname(nickname: String)
}

extension AuthAPI: BaseAPI {

    public static var apiType: APIType = .auth

    public var path: String {
        switch self {
        case .delete:
            return ""
        case .reissuanceToken:
            return "/re-issue"
        case let .nickname(nickname):
            return "/nickname/\(nickname)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .delete:
            return .delete
        case .reissuanceToken:
            return .get
        case .nickname:
            return .get
        }
    }

    public var task: Moya.Task {
        switch self {
        case .delete, .nickname:
            return .requestPlain
        case let .reissuanceToken(refreshToken):
            let parameters: [String: Any] = [
                "refresh_token": refreshToken
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    public var headers: [String : String]? {
        switch self {
        case let .delete(accessToken):
            return ["Authorization": "\(accessToken)"]
        default:
            return nil
        }
    }
}
