import Foundation

import Moya
import Core
import Alamofire

public enum PostureAPI {
    case postureShow(accessToken: String, id: Int)
    case postureSearch(accessToken: String, tag: String)
    case postureRecommand(accessToken: String)
    case postureAllShow(accessToken: String, last_updated: String)
    case postureAdd(accessToken: String,
                    simple_name: String,
                    exact_name: String,
                    thumbnail: String,
                    pose_images: [String],
                    simple_part: [String],
                    exact_part: [String],
                    start_pose: [String],
                    exercise_way: [String],
                    breathe_way: [String],
                    caution: [String],
                    need_machine: Bool
    )
}

extension PostureAPI: BaseAPI {

    public static var apiType: APIType = .posture

    public var path: String {
        switch self {
        case let .postureShow(_, id):
            return "/\(id)"
        case .postureSearch:
            return "/tag"
        case .postureAllShow:
            return "/all"
        case .postureRecommand, .postureAdd:
            return ""
        }
    }

    public var method: Moya.Method {
        switch self {
        case .postureShow,
             .postureSearch,
             .postureRecommand,
             .postureAllShow:
            return .get
        case .postureAdd:
            return .post
        }
    }

    public var task: Moya.Task {
        switch self {
        case let .postureSearch(_, tag):
            let parameters: [String: Any] = [
                "tag": tag
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .postureAllShow(_, last_updated):
            let parameters: [String: Any] = [
                "last_updated": last_updated
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .postureAdd(_,
                             simple_name,
                             exact_name,
                             thumbnail,
                             pose_images,
                             simple_part,
                             exact_part,
                             start_pose,
                             exercise_way,
                             breathe_way,
                             caution,
                             need_machine):
            let params: [String: Any] = [
                "simple_name": simple_name,
                "exact_name": exact_name,
                "thumbnail": thumbnail,
                "pose_images": pose_images,
                "simple_part": simple_part,
                "exact_part": exact_part,
                "start_pose": start_pose,
                "exercise_way": exercise_way,
                "breathe_way": breathe_way,
                "caution": caution,
                "need_machine": need_machine,
            ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case let .postureShow(accessToken, _),
            let .postureSearch(accessToken, _),
            let .postureRecommand(accessToken),
            let .postureAllShow(accessToken, _),
            let .postureAdd(accessToken, _, _, _, _, _, _, _, _, _, _, _):
            return ["Authorization": "\(accessToken)"]
        }
    }
}
