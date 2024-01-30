////
////  HomeUseCase.swift
////  Domain
////
////  Created by 박준하 on 1/30/24.
////  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
////
//
import UIKit

import RxSwift
import RxCocoa

import Core

public protocol HomeUseCase {
    var serviceState: PublishSubject<ServiceStateModel> { get }
    
    func getServiceState()
}

public class DefaultHomeUseCase {
  
    private let repository: HomeRepositoryInterface
    private let disposeBag = DisposeBag()
    
    public let serviceState = PublishSubject<ServiceStateModel>()
    
    public init(repository: HomeRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultHomeUseCase: HomeUseCase {
    public func getServiceState() {
        repository.getServiceState()
            .subscribe(
                onSuccess: { [weak self] serviceStateModel in
                    self?.serviceState.onNext(serviceStateModel)
                },
                onFailure: { [weak self] error in
                    print("MainUseCase getServiceState error occurred: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
}

