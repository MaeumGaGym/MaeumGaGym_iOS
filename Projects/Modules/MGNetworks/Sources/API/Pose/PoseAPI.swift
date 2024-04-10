import Foundation

import Moya
import Core
import Alamofire

public enum PoseAPI {
    case poseCheck(accessToken: String, id: Int)
    case poseSearch(accessToken: String, tag: String)
    case poseRecommand(accessToken: String, tag: String)
}

extension PoseAPI: BaseAPI {

    public static var apiType: APIType = .pose

    public var path: String {
        switch self {
        case let .poseCheck(_, id):
            return "/\(id)"
        case .poseSearch:
            return "/tag"
        case .poseRecommand:
            return ""
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var task: Moya.Task {
        switch self {
        case .poseCheck:
            return .requestPlain
        case let .poseSearch(_, tag):
            let parameters: [String: Any] = [
                "tag": tag
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .poseRecommand(_,tag):
            let parameters: [String: Any] = [
                "tag": tag
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String : String]? {
        switch self {
        case let .poseCheck(accessToken, _):
            return ["Authorization": "\(accessToken)"]
        case let .poseSearch(accessToken, _):
            return ["Authorization": "\(accessToken)"]
        case let .poseRecommand(accessToken, _):
            return ["Authorization": "\(accessToken)"]
        }
    }
}
