//
//  HomeRepository.swift
//  Data
//
//  Created by 박준하 on 1/30/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation
import RxSwift

import Domain

public class HomeRepository: HomeRepositoryInterface {
    public func getServiceState() -> Single<ServiceStateModel> {
        let serviceStateModel = ServiceStateModel(isAvailable: true)
        return Single.just(serviceStateModel)
    }
    
    public init() {
        
    }
}
