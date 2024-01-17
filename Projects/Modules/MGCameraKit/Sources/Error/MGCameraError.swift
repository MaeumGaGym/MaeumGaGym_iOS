//
//  MGCameraError.swift
//  MGCameraKit
//
//  Created by 박준하 on 1/17/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

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
