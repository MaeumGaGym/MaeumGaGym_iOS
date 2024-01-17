import UIKit
import Foundation

public enum MGCameraKitError: Error {
    case MGCameraError(CameraError)
    case MGFilterError(FilterError)
    case MGAlbumError(AlbumError)
}

public enum MGCameraError: Error {
    case captureStillImageOutput
    case imageData
}
