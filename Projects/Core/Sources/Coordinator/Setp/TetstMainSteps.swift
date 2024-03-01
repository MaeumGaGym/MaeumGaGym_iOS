//
//  TetstMainSteps.swift
//  Core
//
//  Created by 박준하 on 3/1/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import RxFlow

public enum TetstMainSteps: Step {
    case initialization
    case back
    case dismiss
    // Main
    case home
    case setting
    // Home
    case infoRequired
    // Setting
    case firstRequired
    case thirdRequired
    case modalRequired
}
