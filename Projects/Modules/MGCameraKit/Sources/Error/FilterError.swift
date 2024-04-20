import Foundation

public enum FilterError {
    case filterFailed, noWorking, noPermission

    var errorDescription: String {
        switch self {
        case .filterFailed:
            return "필터를 적용하지 못했습니다."
        case .noWorking:
            return "필터가 적용되었지만 변경되지 않았습니다."
        case .noPermission:
            return "필터 적용 권한이 없습니다."
        }
    }
}
