import Foundation
import UIKit

import RxSwift
import RxCocoa

import BaseFeatureDependency
import Core

public protocol HomeCoordintable {
    var disposeBag: DisposeBag { get set }
}

public typealias HomeViewModelType = BaseViewModel
public typealias HomePresentable = (vc: UIViewController, vm: any HomeViewModelType)
