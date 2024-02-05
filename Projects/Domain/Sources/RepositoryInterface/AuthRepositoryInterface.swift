//
//  AuthRepositoryInterface.swift
//  Domain
//
//  Created by 박준하 on 2/5/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

public protocol AuthRepositoryInterface {
    func requestSignIn(token: String) -> Single<Bool>
    func kakaoToken(access_token: String) -> Single<String>
}
