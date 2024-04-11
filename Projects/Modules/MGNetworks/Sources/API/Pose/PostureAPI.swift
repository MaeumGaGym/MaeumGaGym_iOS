import Foundation

import Moya
import Core
import Alamofire

public enum PostureAPI {
    case postureCheck(accessToken: String, id: Int)
    case postureSearch(accessToken: String, tag: String)
    case postureRecommand(accessToken: String, tag: String)
}

extension PostureAPI: BaseAPI {

    public static var apiType: APIType = .posture

    public var path: String {
        switch self {
        case let .postureCheck(_, id):
            return "/\(id)"
        case .postureSearch:
            return "/tag"
        case .postureRecommand:
            return ""
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var task: Moya.Task {
        switch self {
        case .postureCheck:
            return .requestPlain
        case let .postureSearch(_, tag):
            let parameters: [String: Any] = [
                "tag": tag
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .postureRecommand(_,tag):
            let parameters: [String: Any] = [
                "tag": tag
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String : String]? {
        switch self {
        case let .postureCheck(accessToken, _):
            return ["Authorization": "\(accessToken)"]
        case let .postureSearch(accessToken, _):
            return ["Authorization": "\(accessToken)"]
        case let .postureRecommand(accessToken, _):
            return ["Authorization": "\(accessToken)"]
        }
    }
}
