import Foundation

import RxFlow
import RxCocoa
import RxSwift

import RxMoya
import Moya

import Core

import AuthFeatureInterface
import Domain
import MGNetworks

import KakaoSDKAuth
import KakaoSDKUser
import MGLogger

import TokenManager

import AuthenticationServices

public class IntroViewModel: AuthViewModelType {

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

    public var goolgeButtonTap: (() -> Void)?
    public var appleButtonTap: (() -> Void)?
    public var kakaoButtonTap: (() -> Void)?

    private let introModelSubject = PublishSubject<IntroModel>()

    public init(authUseCase: AuthUseCase) {
        self.useCase = authUseCase
        self.disposeBag = DisposeBag()
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {

        let output = Output(introDatas: introModelSubject.asObservable())

        action(output)

        bindOutput(output: output)

        useCase.getCSRFToken()
            .subscribe(onSuccess: { token in
                if TokenManagerImpl().save(token: token, with: self.keychainCSRF) {
                    print("토큰 저장 성공")
                } else {
                    print("토큰 저장 실패")
                }
            }, onFailure: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)

        input.goolgeButtonTapped
            .drive(onNext: { [weak self] _ in
                print("이건 은호가 해보자")
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

        useCase.appleLoginResult
            .subscribe(onNext: { token in
                MGLogger.debug("여기 토큰 \(token)")
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
