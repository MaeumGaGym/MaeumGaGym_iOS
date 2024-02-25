import UIKit

import RxSwift

public protocol SelfCareRepositoryInterface {
    func getMyRoutineData() -> Single<SelfCareMyRoutineModel>
    func getMyRoutineDetailData() -> Single<
    SelfCareMyRoutineDetailModel>
    func getMyRoutineEditData() -> Single<SelfCareMyRoutineEditModel>
    func getTargetMainData() -> Single<SelfCareTargetMainModel>
}
