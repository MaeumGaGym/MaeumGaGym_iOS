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

import Core

import AuthFeatureInterface
import Domain

public class IntroViewModel: AuthViewModelType {

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

        input.goolgeButtonTapped
            .drive(onNext: { [weak self] _ in
                self?.useCase.requestSignIn(token: "googleToken")
            })
            .disposed(by: disposeBag)

           input.kakaoButtonTapped
               .drive(onNext: { [weak self] _ in
                   self?.kakaoButtonTap?()
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
