import Foundation

import Moya
import Core
import Alamofire

import Domain

public enum AuthAPI {
    case delete(param: DeleteRequestDTO)
    case reissuanceToken(param: TokenRefreshRequestDTO)
    case checkNickname(param: CheckNicknameRequestDTO)
}

extension AuthAPI: BaseAPI {

    public static var apiType: APIType = .auth

    public var path: String {
        switch self {
        case .delete:
            return ""
        case .reissuanceToken:
            return "/re-issue"
        case .checkNickname(let param):
            return "/nickname/\(param.nickname)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .delete:
            return .delete
        case .reissuanceToken:
            return .get
        case .checkNickname:
            return .get
        }
    }

    public var task: Moya.Task {
        switch self {
        case .delete, .checkNickname:
            return .requestPlain
        case .reissuanceToken(let param):
            let parameters: [String: Any] = [
                "refresh_token": param.refreshToken
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .delete(let param):
            return ["Authorization": "\(param.accessToken)"]
        default:
            return nil
        }
    }
}
