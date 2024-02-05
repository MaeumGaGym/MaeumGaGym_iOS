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
    
    public init() {
        
    }
}
