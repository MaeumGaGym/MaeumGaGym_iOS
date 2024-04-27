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
                AuthStepper.shared.steps.accept(MGStep.authAgreeIsRequired)
            })
            .disposed(by: disposeBag)

        input.kakaoButtonTapped
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.useCase.kakaoButtonTap()
            })
            .disposed(by: disposeBag)

        input.appleButtonTapped
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.useCase.appleButtonTap()
            })
            .disposed(by: disposeBag)

        input.getIntroData
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.useCase.getIntroData()
            })
            .disposed(by: disposeBag)

        return output
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

private extension IntroViewModel {
    //    func kakaoGetUserInfo() {
    //        UserApi.shared.me() { (user, error) in
    //            if let error = error {
    //                print(error)
    //            }
    //
    //            let userName = user?.kakaoAccount?.name
    //
    //            _ = "user name : \(String(describing: userName))"
    //
    //            print("user - \(String(describing: user))")
    //        }
    //    }
}
