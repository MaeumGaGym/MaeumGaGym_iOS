import Foundation
import UIKit

import RxSwift
import RxCocoa

import BaseFeatureDependency
import Core

public protocol HomeCoordintable {
    var onSettingButtonTap: (() -> Void)? { get set }
    var onStepNumberButtonTap: (() -> Void)? { get set}
    var routineButtonTap: (() -> Void)? { get set}
    var calorieCalculatorButtonTap: (() -> Void)? { get set }
    var maeumGaGymTimerButtonTap: (() -> Void)? { get set }

    var disposeBag: DisposeBag { get set }
}

public typealias HomeViewModelType = BaseViewModel
public typealias HomePresentable = (vc: UIViewController, vm: any HomeViewModelType)
