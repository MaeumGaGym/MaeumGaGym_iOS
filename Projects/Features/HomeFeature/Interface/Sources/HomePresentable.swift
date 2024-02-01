//
//  HomePresentable.swift
//  HomeFeatureInterface
//
//  Created by 박준하 on 1/30/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

import BaseFeatureDependency
import Core

public protocol HomeViewControllable: ViewControllable {}
public protocol HomeCoordintable {
    var onSettingButtonTap: (() -> Void)? { get set }
    var onStepNumberButtonTap: (() -> Void)? { get set}
    var routineButtonTap: (() -> Void)? { get set}
    var calorieCalculatorButtonTap: (() -> Void)? { get set }
    var maeumGaGymTimerButtonTap: (() -> Void)? { get set }

    var disposeBag: DisposeBag { get set }
}

public typealias HomeViewModelType = BaseViewModel & HomeCoordintable
public typealias HomePresentable = (vc: HomeViewControllable, vm: any HomeViewModelType)
