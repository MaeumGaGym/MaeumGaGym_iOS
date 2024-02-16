import Foundation

import RxSwift
import RxCocoa

import BaseFeatureDependency
import Core

public protocol AuthViewControllable: ViewControllable {}
public protocol AuthCoordintable {
//    var goolgeButtonTap: (() -> Void)? { get set }
//    var appleButtonTap: (() -> Void)? { get set }
//    var kakaoButtonTap: (() -> Bool)? { get set }

    var disposeBag: DisposeBag { get set }
}

public typealias AuthViewModelType = BaseViewModel & AuthCoordintable
public typealias AuthPresentable = (vc: AuthViewControllable, vm: any AuthViewModelType)
