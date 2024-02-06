//
//  IntroViewModel.swift
//  AuthFeatureInterface
//
//  Created by 박준하 on 2/2/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

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

public class IntroViewModel: AuthViewModelType {

    let provider = MoyaProvider<CsrfAPI>()

    public var disposeBag: RxSwift.DisposeBag

    private let useCase: AuthUseCase

    let keychainCSRF = KeychainType.CSRFToken

    public struct Input {
        let goolgeButtonTapped: Driver<Void>
        let appleButtonTapped: Driver<Void>
        let kakaoButtonTapped: Driver<Void>
    }

    public struct Output { 
        let loginResult: Driver<Result<AuthHandleableType, Error>>
    }

    public var goolgeButtonTap: (() -> Void)?
    public var appleButtonTap: (() -> Void)?
    public var kakaoButtonTap: (() -> Void)?

    public init(authUseCase: AuthUseCase) {
         self.useCase = authUseCase
        self.disposeBag = DisposeBag()
     }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {

           let loginResultSubject = PublishSubject<Result<AuthHandleableType, Error>>()

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
                self?.useCase.requestSignIn(token: "googleToken")
            })
            .disposed(by: disposeBag)

           input.kakaoButtonTapped
               .drive(onNext: { [weak self] _ in
                   self?.useCase.kakaoButtonTap()
               })
               .disposed(by: disposeBag)

           input.appleButtonTapped
               .drive(onNext: { [weak self] _ in
                   self?.appleButtonTap?()
               })
               .disposed(by: disposeBag)

           let output = Output(loginResult: loginResultSubject.asDriver(onErrorJustReturn: .failure(AuthError.unknown)))

           action(output)

           return output
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
