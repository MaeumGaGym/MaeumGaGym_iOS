//
//  AppStepper.swift
//  RootFeatureTests
//
//  Created by 박준하 on 11/6/23.
//  Copyright © 2023 MaeumGaGym-iOS. All rights reserved.
//

import Foundation
import RxFlow
import RxCocoa
import Core
import RxSwift

public class AppStepper: Stepper {

    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    public init() {
    }

    public var initialStep: Step {
        return AppStep.loginIsRequired
    }
}
