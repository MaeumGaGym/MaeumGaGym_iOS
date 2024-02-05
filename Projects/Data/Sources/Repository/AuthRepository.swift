//
//  AuthRepository.swift
//  Data
//
//  Created by 박준하 on 2/5/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import MGNetworks

public class AuthRepository: AuthRepositoryInterface {

    private let networkService: AuthService

    public init(networkService: AuthService) {
        self.networkService = networkService
    }

    public func requestSignIn(token: String) -> Single<Bool> {
        return networkService.requestToken()
    }

    public func kakaoToken(access_token: String) -> Single<String> {
        networkService.kakaoTokenState(access_token: access_token)
    }
}
