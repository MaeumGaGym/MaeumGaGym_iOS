//
//  SignInRepositoryInterface.swift
//  Domain
//
//  Created by 박준하 on 2/6/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import RxSwift

public protocol SignInRepositoryInterface {
    func requestSignIn(token: String) -> Single<Bool>
}
