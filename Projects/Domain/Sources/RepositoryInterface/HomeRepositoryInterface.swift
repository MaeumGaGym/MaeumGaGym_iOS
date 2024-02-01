//
//  HomeRepositoryInterface.swift
//  Domain
//
//  Created by 박준하 on 1/30/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

public protocol HomeRepositoryInterface {
    func getServiceState() -> Single<ServiceStateModel>
}