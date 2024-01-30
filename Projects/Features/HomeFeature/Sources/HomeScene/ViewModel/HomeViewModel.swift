//
//  HomeViewModel.swift
//  HomeFeatureInterface
//
//  Created by 박준하 on 1/30/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core
import Domain

import HomeFeatureInterface

public class HomeViewModel: HomeViewModelType {
    public var disposeBag: DisposeBag = DisposeBag()

    private let useCase: HomeUseCase

    public struct Input {
         public let viewDidLoad: Driver<Void>
         public let myPageButtonTapped: Driver<Void>

         public init(viewDidLoad: Driver<Void>, myPageButtonTapped: Driver<Void>) {
             self.viewDidLoad = viewDidLoad
             self.myPageButtonTapped = myPageButtonTapped
         }
     }

    public struct Output {
        public let isServiceAvailable: Observable<Bool>
        public let needNetworkAlert: Observable<Void>
    }

    public init(useCase: HomeUseCase) {
        self.useCase = useCase
    }

    public var onSettingButtonTap: (() -> Void)?
    public var onStepNumberButtonTap: (() -> Void)?
    public var routineButtonTap: (() -> Void)?
    public var calorieCalculatorButtonTap: (() -> Void)?
    public var maeumGaGymTimerButtonTap: (() -> Void)?
    
    private let needToReloadSubject = PublishSubject<Void>()
    private let isServiceAvailableSubject = PublishSubject<Bool>()
    private let needNetworkAlertSubject = PublishSubject<Void>()
    
    public func transform(_ input: Input) -> Output {
        
        input.viewDidLoad
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.useCase.getServiceState()
            }).disposed(by: DisposeBag())
        
        return Output(
            isServiceAvailable: isServiceAvailableSubject.asObservable(),
            needNetworkAlert: needNetworkAlertSubject.asObservable()
        )
    }
    
    private func bindOutput(output: Output) {
        
        useCase.serviceState
            .subscribe(onNext: { serviceState in
                self.isServiceAvailableSubject.onNext(serviceState.isAvailable)
            }).disposed(by: disposeBag)
    }
}
