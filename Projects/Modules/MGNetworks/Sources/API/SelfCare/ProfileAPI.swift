import Foundation

import Moya

import TokenManager

public enum ProfileAPI {
    case profileCheck(accessToken: String, userName: String)
    case profileInfoModify(accessToken: String, nickName: String, height: Double, weight: Double, gender: String)
}

extension ProfileAPI: BaseAPI {
    public static var apiType: APIType = .profile

    public var path: String {
        switch self {
        case .profileCheck(let userName, _):
            return "/\(userName)"
        case .profileInfoModify:
            return ""
        }
    }

    public var method: Moya.Method {
        switch self {
        case .profileCheck:
            return .get
        case .profileInfoModify:
            return .put
        }
    }

    public var task: Moya.Task {
        switch self {
        case let .profileInfoModify(_, nickName, height, weight, gender):
            return .requestParameters(parameters: [
                "nickname": nickName,
                "weight": weight,
                "height": height,
                "gender": gender
            ], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case let .profileCheck(accessToken, _),
            let .profileInfoModify(accessToken, _, _ , _, _):
            return ["Authorization": "\(accessToken)"]
        }
    }

}
