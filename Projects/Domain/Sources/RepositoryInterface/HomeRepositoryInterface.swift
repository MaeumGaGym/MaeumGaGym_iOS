import UIKit

import RxSwift
import RxCocoa

public protocol HomeRepositoryInterface {
    func getMotivationMessage() -> Single<MotivationMessageModel>
    func getStepNumber() -> Single<StepModel>
    func getRoutines() -> Single<[RoutineModel]>
    func getExtras() -> Single<[ExtrasModel]>
}
