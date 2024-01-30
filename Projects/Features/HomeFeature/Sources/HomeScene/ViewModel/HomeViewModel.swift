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

public class HomeViewModel: HomeViewModelType {
    
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

    // Coordinator 클로저 정의
    public var onSettingButtonTap: (() -> Void)?
    public var onStepNumberButtonTap: (() -> Void)?
    public var routineButtonTap: (() -> Void)?
    public var calorieCalculatorButtonTap: (() -> Void)?
    public var maeumGaGymTimerButtonTap: (() -> Void)?
    
    private let needToReloadSubject = PublishSubject<Void>()
    private let isServiceAvailableSubject = PublishSubject<Bool>()
    private let needNetworkAlertSubject = PublishSubject<Void>()
    
    public init() {

    }
    
    public func transform(_ input: Input) -> Output {
        
        return Output(
            isServiceAvailable: isServiceAvailableSubject.asObservable(),
            needNetworkAlert: needNetworkAlertSubject.asObservable()
        )
    }
}
