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
        case .delete, .reissuanceToken, .nickname:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case let .delete(accessToken):
            return ["Authorization": "\(accessToken)"]
        case let .reissuanceToken(refreshToken):
            return ["RF-TOKEN": "\(refreshToken)"]
        default:
            return nil
        }
    }
}
