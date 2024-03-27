import UIKit

import RxSwift
import RxCocoa

import Domain

import MGLogger

import MindGymKit
import Combine

public class HomeService {
    public func requestServiceState() -> Single<ServiceStateModel> {
        return Single.just(ServiceStateModel(isAvailable: true))
    }

    public func requestMotivationMessage() -> Single<MotivationMessageModel> {
        return Single.just(MotivationMessageModel(text: "가능성은 한계를 넘는다.", author: "Kimain"))
    }

    public func requestStepNumber() -> Observable<StepModel> {
        return Observable<Int>.interval(.seconds(5), scheduler: MainScheduler.instance)
            .flatMapLatest { _ in
                self.fetchStepCount().asObservable()
            }
    }

    private func fetchStepCount() -> Single<StepModel> {
        return Single.create { single in
            let provider = HealthKitStepCountProvider()
            provider.fetchTodayStepCount { stepCount in
                if let count = stepCount {
                    MGLogger.debug("성공했습니다 걷기 데이터입니다 \(count)")
                    single(.success(StepModel(stepCount: count)))
                } else {
                    MGLogger.error("치명적으로 실패했습니다, 걷기 데이터를 가져오는데 실패했습니다.")
//                    single(.failure(StepModel(stepCount: 0) as! Error))
                }
                
                MGLogger.debug("\(String(describing: stepCount))자리입니다")
            }
            return Disposables.create()
        }
    }

    public func requestRoutines() -> Single<[RoutineModel]> {
        let routines: [RoutineModel] = [
            RoutineModel(exercise: "벤치", sets: 2, reps: 10),
            RoutineModel(exercise: "팔굽혀펴기", sets: 3, reps: 11),
            RoutineModel(exercise: "러닝", sets: 5, reps: 12),
            RoutineModel(exercise: "러닝", sets: 5, reps: 13)
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
