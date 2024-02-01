import UIKit

import DSKit

public struct SelfCareContent {
    var name: String
    var routineState: RoutineState
    var sharedState: SharedState
}

public enum SelfCareMyRoutineModel {
    case myRoutine
    
    var data: [SelfCareContent] {
        switch self {
        case .myRoutine:
            return [
                SelfCareContent(name: "주말 루틴", routineState: .useRoutine, sharedState: .yesShared),
                SelfCareContent(name: "매일 루틴", routineState: .keepRoutine, sharedState: .notShared),
                SelfCareContent(name: "평일 루틴", routineState: .useRoutine, sharedState: .notShared),
                SelfCareContent(name: "말왕 루틴", routineState: .keepRoutine, sharedState: .yesShared),
                SelfCareContent(name: "루틴 루틴", routineState: .keepRoutine, sharedState: .yesShared),
                SelfCareContent(name: "이은호 루틴", routineState: .keepRoutine, sharedState: .notShared),
                SelfCareContent(name: "부현수 루틴", routineState: .useRoutine, sharedState: .notShared),
                SelfCareContent(name: "이태영 루틴", routineState: .useRoutine, sharedState: .yesShared),
                SelfCareContent(name: "플러터1 루틴", routineState: .keepRoutine, sharedState: .notShared),
                SelfCareContent(name: "플러터2 루틴", routineState: .useRoutine, sharedState: .yesShared),
            ]
        }
    }
}
