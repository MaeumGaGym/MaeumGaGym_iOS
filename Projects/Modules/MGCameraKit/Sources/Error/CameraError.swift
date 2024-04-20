import Foundation

public enum CameraError {
    case noCamera, noWorking, noCapturing, noPermission, noZoom, noFlash, noTransform

    var errorDescription: String {
        switch self {
        case .noCamera:
            return "카메라가 작동하지 않습니다."
        case .noWorking:
            return "카메라가 작동하지만 캡처하지 않습니다."
        case .noCapturing:
            return "사진을 캡처할 수 없습니다."
        case .noPermission:
            return "카메라에 접근할 수 있는 권한이 없습니다."
        case .noZoom:
            return "카메라를 확대/축소할 수 없습니다."
        case .noFlash:
            return "카메라 플래시를 활성화할 수 없습니다."
        case .noTransform:
            return "카메라 방향을 회전할 수 없습니다."
        }
    }
}
