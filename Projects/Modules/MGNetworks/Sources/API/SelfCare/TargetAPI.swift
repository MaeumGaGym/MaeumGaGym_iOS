import Foundation

import Moya
import Core
import Alamofire

public enum TargetAPI {
    case targetAdd(accessToken: String,
                   title: String,
                   content: String,
                   startDate: String,
                   endDate: String)
    case targetEdit(accessToken: String,
                    title: String,
                    content: String,
                    startDate: String,
                    endDate: String,
                    id: Int)
    case targetDelete(accessToken: String, id: Int)
    case getTarget(accessToken: String, id: Int)
    case getMonthTarget(accessToken: String, date: String)
    case getMyTarget(accessToken: String)
}

extension TargetAPI: BaseAPI {

    public static var apiType: APIType = .target

    public var path: String {
        switch self {
        case .targetAdd:
            return ""
        case let .targetEdit(_, _, _, _, _, id):
            return "/\(id)"
        case let .targetDelete(_, id):
            return "/\(id)"
        case let .getTarget(_, id):
            return "/\(id)"
        case .getMonthTarget(let date):
            return "/month/\(date)"
        case .getMyTarget:
            return "/my"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .targetAdd, .targetEdit:
            return .post
        case .targetDelete:
            return .delete
        case .getMonthTarget, .getMyTarget, .getTarget:
            return .get
        }
    }

    public var task: Moya.Task {
        switch self {
        case let .targetAdd(_,
                            title,
                            content,
                            startDate,
                            endDate):
            let params: [String: Any] = [
                "title": title,
                "content": content,
                "start_date": startDate,
                "end_date": endDate
            ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .targetEdit(_, title,
                             content,
                             startDate,
                             endDate,
                             _):
            let params: [String: Any] = [
                "title": title,
                "content": content,
                "start_date": startDate,
                "end_date": endDate
            ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case let .getMonthTarget(accessToken, _),
            let .targetAdd(accessToken, _, _, _, _),
            let .targetEdit(accessToken, _, _, _, _, _),
            let .targetDelete(accessToken, _),
            let .getTarget(accessToken, _),
            let .getMyTarget(accessToken):
            return ["Authorization": "\(accessToken)"]
        }
    }
}
