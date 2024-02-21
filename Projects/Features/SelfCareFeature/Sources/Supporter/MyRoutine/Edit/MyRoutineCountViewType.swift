import Foundation

public enum MyRoutineCountViewType {
    case number
    case set

    var text: String {
        switch self {
        case .number:
            return "횟수"
        case .set:
            return "세트"
        }
    }
}
