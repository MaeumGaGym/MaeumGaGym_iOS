import Foundation

import RxFlow
import RxCocoa
import RxSwift

import RxMoya
import Moya

import Core
import Domain
import MGNetworks

import KakaoSDKAuth
import KakaoSDKUser
import MGLogger

import TokenManager
import AuthFeatureInterface

public class IntroViewModel: AuthViewModelType {

    public typealias ViewModel = IntroViewModel

    public var disposeBag: DisposeBag

    private let useCase: AuthUseCase

    public struct Input {
        let goolgeButtonTapped: Driver<Void>
        let appleButtonTapped: Driver<Void>
        let kakaoButtonTapped: Driver<Void>
        let getIntroData: Driver<Void>
    }

    public struct Output {
        var introDatas: Observable<IntroModel>
        var showGoogleAlert: Observable<Void>
    }

    private let introModelSubject = PublishSubject<IntroModel>()
    private let showGoogleAlertSubject = PublishSubject<Void>()

    public init(authUseCase: AuthUseCase) {
        self.useCase = authUseCase
        self.disposeBag = DisposeBag()
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {

        let output = Output(
            introDatas: introModelSubject.asObservable(),
            showGoogleAlert: showGoogleAlertSubject.asObservable()
        )

        action(output)
        bindInputs(input)
        bindOutput(output: output)

        return output
    }
    
    private func bindButtonTap(_ driver: Driver<Void>, handler: @escaping () -> Void) {
        driver
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                handler()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindInputs(_ input: Input) {
        bindButtonTap(input.goolgeButtonTapped, handler: { self.showGoogleAlertSubject.onNext(()) })
        bindButtonTap(input.appleButtonTapped, handler: { self.useCase.appleButtonTap() })
        bindButtonTap(input.kakaoButtonTapped, handler: { self.useCase.kakaoButtonTap() })
        bindButtonTap(input.getIntroData, handler: { self.useCase.getIntroData() })
    }

    private func bindOutput(output: Output) {
        useCase.introData
            .withUnretained(self)
            .subscribe(onNext: { owner, introData in
                owner.introModelSubject.onNext(introData)
                MGLogger.debug(introData)
            }).disposed(by: disposeBag)

        useCase.appleSignupResult
            .subscribe(onNext: { token in
                MGLogger.debug("\(token)")
            })
            .disposed(by: disposeBag)
    }
}
