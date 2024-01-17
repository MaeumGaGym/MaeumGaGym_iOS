//
//  FilterError.swift
//  MGCameraKit
//
//  Created by 박준하 on 1/17/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

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
