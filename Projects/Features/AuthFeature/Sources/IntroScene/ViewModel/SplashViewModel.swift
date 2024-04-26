import Foundation

import RxFlow
import RxCocoa
import RxSwift

import RxMoya
import Moya

import Core
import Domain

import TokenManager
import AuthFeatureInterface

public class SplashViewModel: AuthViewModelType {

    public typealias ViewModel = SplashViewModel

    public var disposeBag: RxSwift.DisposeBag

    private let useCase: AuthUseCase

    public struct Input {}

    public struct Output {}


    public init(authUseCase: AuthUseCase) {
        self.useCase = authUseCase
        self.disposeBag = DisposeBag()
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        
        let ouput = Output()
        action(ouput)

//        useCase.appleSignupResult()

        return Output()
    }
}
