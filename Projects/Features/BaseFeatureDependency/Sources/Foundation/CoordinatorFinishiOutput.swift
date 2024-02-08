//
//  CoordinatorFinishiOutput.swift
//  BaseFeatureDependency
//
//  Created by 박준하 on 2/6/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation

public protocol CoordinatorFinishOutput {
    var finishFlow: (() -> Void)? { get set }
}

public typealias DefaultCoordinator = BaseCoordinator & CoordinatorFinishOutput
