import Foundation

public enum AlbumError {
    case saveError, noWorking, noPermission

    var errorDescription: String {
        switch self {
        case .saveError:
            return "사진을 저장할 수 없습니다."
        case .noWorking:
            return "사진을 저장할 수 없습니다."
        case .noPermission:
            return "사진 저장 권한이 없습니다."
        }
    }
}
