//
//  AuthService.swift
//  MGNetworks
//
//  Created by 박준하 on 2/5/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Domain

public class AuthService {
    
    public func requestToken() -> Single<Bool> {
        return Single.just(true)
    }
    
    public func kakaoTokenState(access_token: String) -> Single<String> {
        return Single.deferred {
            return Single.create { single in
                let result = access_token
                
                single(.success(result))
                
                return Disposables.create()
            }
        }
    }
    
    public init() {
        
    }
}
