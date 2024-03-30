import Foundation

import Moya
import Core
import Alamofire

public enum RoutineAPI {
    case routineAdd(accessToken: String,
                    name: String,
                    isAchived: Bool,
                    isShared: Bool,
                    exerciseInfoModelList: [ExerciseInfoModel],
                    dayOfWeeks: [String]?)
    case routineMyAll(accessToken: String)
    case routineTodayMyAll(accessToken: String)
    case routineDelete(accessToken: String, id: Int64)
    case routineEdit(accessToken: String,
                     name: String,
                     isArchived: Bool,
                     isShared: Bool,
                     exerciseInfoModelList: [ExerciseInfoModel]?,
                     dayOfWeeks: [String]?,
                     id: Int64)
    case routineTodayComplete(accessToken: String)
    case routineMonthCheck(accessToken: String, date: String)
}

public struct ExerciseInfoModel: Codable {
    let exerciseName: String
    let repetitions: Int
    let sets: Int
}

extension RoutineAPI: BaseAPI {

    public static var apiType: APIType = .routine

    public var path: String {
        switch self {
        case .routineAdd:
            return ""
        case .routineMyAll:
            return "/me/all"
        case .routineTodayMyAll:
            return "/today"
        case let .routineDelete(accessToken, id):
            return "/\(id)"
        case let .routineEdit(accessToken,
                              name,
                              isArchived,
                              isShared,
                              exerciseInfoModelList,
                              dayOfWeeks,
                              id):
            return "/\(id)"
        case .routineTodayComplete:
            return "/today/complete"
        case let .routineMonthCheck(accessToken, date):
            return "/histories/\(date)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .routineAdd:
            return .post
        case .routineMyAll, .routineTodayMyAll, .routineMonthCheck:
            return .get
        case .routineDelete:
            return .delete
        case .routineEdit, .routineTodayComplete:
            return .put
        }
    }

    public var task: Moya.Task {
        switch self {
        case let .routineAdd(_, name,
                             isArchived, isShared,
                             exerciseInfoModelList, dayOfWeeks):
            var params: [String: Any] = [
                "routine_name": name,
                "is_archived": isArchived,
                "is_shared": isShared,
                "exercise_info_model_list": exerciseInfoModelList.map { ["exercise_name": $0.exerciseName, "repetitions": $0.repetitions, "sets": $0.sets]
                }
            ]
            if let dayOfWeeks = dayOfWeeks {
                params["day_of_weeks"] = dayOfWeeks
            }
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .routineEdit(_,
                              name,
                              isArchived,
                              isShared,
                              exerciseInfoModelList,
                              dayOfWeeks,
                              id):
            var params: [String: Any] = [
                "routine_name": name,
                "is_archived": isArchived,
                "is_shared": isShared,
            ]
            if let exerciseInfoModelList = exerciseInfoModelList {
                params["exercise_info_model_list"] = exerciseInfoModelList.map { ["exercise_name": $0.exerciseName, "repetitions": $0.repetitions, "sets": $0.sets]
                }
            }
            if let dayOfWeeks = dayOfWeeks {
                params["day_of_weeks"] = dayOfWeeks
            }
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case let .routineAdd(accessToken, _, _, _, _, _),
            let .routineMyAll(accessToken),
            let .routineTodayMyAll(accessToken),
            let .routineDelete(accessToken, _),
            let .routineEdit(accessToken, _, _, _, _, _, _),
            let .routineTodayComplete(accessToken),
            let .routineMonthCheck(accessToken, _):
            return ["Authorization": "\(accessToken)"]
        }
    }
}
