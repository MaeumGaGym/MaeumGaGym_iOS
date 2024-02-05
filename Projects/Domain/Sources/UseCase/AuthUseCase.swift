//
//  AuthUseCase.swift
//  Domain
//
//  Created by 박준하 on 2/5/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Core
import KakaoSDKUser

public enum AuthHandleableType {
    case loginSuccess
    case loginFailure
}

public protocol AuthUseCase {
    func requestSignIn(token: String)
    func kakaoButtonTap()
    var signInResult: PublishSubject<Result<AuthHandleableType, Error>> { get }
}

public class DefaultAuthUseCase {
    private let authRepository: AuthRepositoryInterface
    private let disposeBag = DisposeBag()

    public init(authRepository: AuthRepositoryInterface) {
        self.authRepository = authRepository
    }
}

extension DefaultAuthUseCase: AuthUseCase {
    public func kakaoButtonTap() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    let accessToken = oauthToken!.accessToken
                    self?.authRepository.kakaoToken(access_token: accessToken)
                        .subscribe(onSuccess: { [weak self] _ in
                            self?.signInResult.onNext(.success(.loginSuccess))
                        }, onFailure: { [weak self] error in
                            self?.signInResult.onNext(.failure(error))
                        })
                        .disposed(by: self!.disposeBag)
                }
            }
        }
    }
    
    public func requestSignIn(token: String) {
        authRepository.requestSignIn(token: token)
            .subscribe(onSuccess: { [weak self] _ in
                self?.signInResult.onNext(.success(.loginSuccess))
                print("성공")
            }, onFailure: { [weak self] error in
                self?.signInResult.onNext(.failure(error))
            })
            .disposed(by: disposeBag)
    }

    public var signInResult: PublishSubject<Result<AuthHandleableType, Error>> {
        return PublishSubject<Result<AuthHandleableType, Error>>()
    }
}
