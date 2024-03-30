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
                    id: Int64)
    case targetDelete(accessToken: String, id: Int64)
    case targetCheck(accessToken: String, id: Int64)
    case targetMonthCheck(accessToken: String, date: String)
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
        case let .targetCheck(_, id):
            return "/\(id)"
        case .targetMonthCheck:
            return ""
        }
    }

    public var method: Moya.Method {
        switch self {
        case .targetAdd, .targetEdit:
            return .post
        case .targetDelete:
            return .delete
        case .targetCheck, .targetMonthCheck:
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
        case let .targetMonthCheck(_, date):
            let params: [String: Any] = ["date": date]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case let .targetMonthCheck(accessToken, _),
            let .targetAdd(accessToken, _, _, _, _),
            let .targetEdit(accessToken, _, _, _, _, _),
            let .targetDelete(accessToken, _),
            let .targetCheck(accessToken, _):
            return ["Authorization": "\(accessToken)"]
        }
    }
}
