import RxSwift

import Domain
import MGNetworks

public class SelfCareRepository: SelfCareRepositoryInterface {

    private let networkService: SelfCareService

    public func getMyRoutineData() -> Single<SelfCareMyRoutineModel> {
        return networkService.requestMyRoutineData()
    }

    public func getMyRoutineDetailData() -> Single<SelfCareMyRoutineDetailModel> {
        return networkService.requestMyRoutineDetailData()
    }

    public func getMyRoutineEditData() -> Single<SelfCareMyRoutineEditModel> {
        return networkService.requestMyRoutineEditData()
    }

    public func getTargetMainData() -> Single<SelfCareTargetMainModel> {
        return networkService.requestTargetMainData()
    }

    public init(networkService: SelfCareService) {
        self.networkService = networkService
    }
}
