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

    public var disposeBag: RxSwift.DisposeBag

    private let useCase: AuthUseCase

    let keychainCSRF = KeychainType.CSRFToken

    public struct Input {
        let goolgeButtonTapped: Driver<Void>
        let appleButtonTapped: Driver<Void>
        let kakaoButtonTapped: Driver<Void>
        let getIntroData: Driver<Void>
    }

    public struct Output {
        var introDatas: Observable<IntroModel>
    }

    private let introModelSubject = PublishSubject<IntroModel>()

    public init(authUseCase: AuthUseCase) {
        self.useCase = authUseCase
        self.disposeBag = DisposeBag()
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {

        let output = Output(introDatas: introModelSubject.asObservable())

        action(output)

        bindOutput(output: output)

        input.goolgeButtonTapped
            .drive(onNext: { _ in
                print("goolgeButtonTapped")
                AuthStepper.shared.steps.accept(MGStep.authAgreeIsRequired)
            })
            .disposed(by: disposeBag)

        input.kakaoButtonTapped
            .drive(onNext: { [weak self] _ in
                self?.useCase.kakaoButtonTap()
            })
            .disposed(by: disposeBag)

        input.appleButtonTapped
              .drive(onNext: { [weak self] _ in
                  self?.useCase.appleButtonTap()
              })
              .disposed(by: disposeBag)

        input.getIntroData
            .drive(onNext: { [weak self] _ in
                self?.useCase.getIntroData()
            }).disposed(by: disposeBag)

        return output
    }

    private func bindOutput(output: Output) {
        useCase.introData
            .subscribe(onNext: { introData in
                self.introModelSubject.onNext(introData)
                MGLogger.debug(introData)
            }).disposed(by: disposeBag)
        
        useCase.appleSignupResult
            .subscribe(onNext: { token in
                MGLogger.debug("\(token)")
            })
            .disposed(by: disposeBag)
    }
}
