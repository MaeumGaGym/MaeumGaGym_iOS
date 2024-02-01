//
//  HomeService.swift
//  MGNetworks
//
//  Created by 박준하 on 1/30/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Domain

public class HomeService {
    public func requestServiceState() -> Single<ServiceStateModel> {
        return Single.just(ServiceStateModel(isAvailable: true))
    }

    public func requestMotivationMessage() -> Single<MotivationMessageModel> {
        return Single.just(MotivationMessageModel(text: "가능성은 한계를 넘는다.", author: "Kimain"))
    }

    public func requestStepNumber() -> Single<StepModel> {
        return Single.just(StepModel(stepCount: 112771))
    }

    public func requestRoutines() -> Single<[RoutineModel]> {
        let routines: [RoutineModel] = [
            RoutineModel(exercise: "벤치", sets: 2, reps: 10),
            RoutineModel(exercise: "팔굽혀펴기", sets: 3, reps: 10),
            RoutineModel(exercise: "러닝", sets: 5, reps: 10),
            RoutineModel(exercise: "러닝", sets: 5, reps: 10)
        ]
        return Single.just(routines)
    }

    public func requestExtras() -> Single<[ExtrasModel]> {
        let extras: [ExtrasModel] = [
            ExtrasModel(image: UIImage(), titleName: "칼로리 계산기", description: "먹은 음식의 칼로리를 계산해 보세요."),
            ExtrasModel(image: UIImage(), titleName: "와카타임", description: "지금까지 한 운동 시간을 확인해 보세요.")
        ]
        return Single.just(extras)
    }
    
    public init() {
        
    }
}
