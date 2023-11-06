//
//  AppStep.swift
//  Core
//
//  Created by 박준하 on 11/6/23.
//  Copyright © 2023 MaeumGaGym-iOS. All rights reserved.
//

import RxFlow
import UIKit

public enum AppStep: Step {
    case tabBarIsRequired
    case homeIsRequired
    case postureIsRequired
    case selfCareIsRequired
    case shopIsRequired
}
