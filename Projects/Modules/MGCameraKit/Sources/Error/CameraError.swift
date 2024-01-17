//
//  CameraError.swift
//  MGCameraKit
//
//  Created by 박준하 on 1/17/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation

public enum CameraError {
    case noCamera, noWorking, noCapturing, noPermission, noZoom, noFlash, noTransform

    var errorDescription: String {
        switch self {
        case .noCamera:
            return "The camera is not functioning."
        case .noWorking:
            return "The camera is working but not capturing."
        case .noCapturing:
            return "Unable to capture photos."
        case .noPermission:
            return "No permission to access the camera."
        case .noZoom:
            return "Unable to zoom the camera."
        case .noFlash:
            return "Unable to activate the camera's flash."
        case .noTransform:
            return "Unable to rotate the camera's orientation."
        }
    }
}
