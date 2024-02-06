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

public class IntroViewModel: AuthViewModelType {

    let provider = MoyaProvider<CsrfAPI>()
    
    public var disposeBag: RxSwift.DisposeBag

    private let useCase: AuthUseCase

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

        provider.rx.request(.getCSRFToken)
            .subscribe(onSuccess: { response in
                if let setCookieHeader =
                    response.response?.allHeaderFields["Set-Cookie"] as? String {
                    let cookies = setCookieHeader.components(separatedBy: ", ")
                    for cookie in cookies {
                        if cookie.hasPrefix("XSRF-TOKEN") {
                            let token = cookie.components(separatedBy: "=")[1].components(separatedBy: ";")[0]
                            print("XSRF-TOKEN is \(token)")
                        }
                    }
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
