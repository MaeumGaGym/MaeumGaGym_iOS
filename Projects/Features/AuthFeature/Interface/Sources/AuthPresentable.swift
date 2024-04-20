import Foundation
import UIKit

import RxSwift
import RxCocoa

import BaseFeatureDependency
import Core

public protocol AuthCoordintable {
    var disposeBag: DisposeBag { get set }
}

public typealias AuthViewModelType = BaseViewModel & AuthCoordintable
public typealias AuthPresentable = (vc: UIViewController, vm: any AuthViewModelType)
