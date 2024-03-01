//
//  TestHomeSteppers.swift
//  Core
//
//  Created by 박준하 on 3/1/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation
import RxFlow
import RxCocoa

public class TestHomeSteppers: Stepper {
    public static let shared = TestHomeSteppers()

    public var steps = PublishRelay<Step>()

    public var initialStep: Step {
        return TetstMainSteps.home
    }
}
