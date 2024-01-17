import Foundation

public enum FilterError {
    case filterFailed, noWorking, noPermission

    var errorDescription: String {
        switch self {
        case .filterFailed:
            return "Failed to apply filters."
        case .noWorking:
            return "Filters applied, but no changes were made."
        case .noPermission:
            return "No permission to apply filters."
        }
    }
}
