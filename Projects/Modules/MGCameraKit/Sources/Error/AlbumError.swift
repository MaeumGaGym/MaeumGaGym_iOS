//
//  AlbumError.swift
//  MGCameraKit
//
//  Created by 박준하 on 1/17/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation

public enum AlbumError {
    case saveError, noWorking, noPermission

    var errorDescription: String {
        switch self {
        case .saveError:
            return "Unable to save the photo."
        case .noWorking:
            return "Unable to save photos."
        case .noPermission:
            return "No permission to save photos."
        }
    }
}
