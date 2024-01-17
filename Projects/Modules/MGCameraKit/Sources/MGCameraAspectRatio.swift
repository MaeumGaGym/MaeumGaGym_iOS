//
//  CameraAspectRatio.swift
//  MGCameraKit
//
//  Created by 박준하 on 1/17/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit
import Foundation

public enum MGCameraAspectRatio {
    case square // 1 : 1
    case full // UIView 전체 채우기
    case portrait // length 16 : 9
    case landscape // width 16 : 9
    case custom(width: CGFloat, height: CGFloat)
}
