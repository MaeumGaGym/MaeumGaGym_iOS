import Foundation
import RxSwift

import Domain

import MGNetworks

public class HomeRepository: HomeRepositoryInterface {
    private let networkService: HomeService

    public func getServiceState() -> Single<ServiceStateModel> {
        let serviceStateModel = ServiceStateModel(isAvailable: true)
        return Single.just(serviceStateModel)
    }
    public func getMotivationMessage() -> Single<MotivationMessageModel> {
        return networkService.requestMotivationMessage()
    }

    public func getStepNumber() -> Single<StepModel> {
        return networkService.requestStepNumber()
    }

    public func getRoutines() -> Single<[RoutineModel]> {
        return networkService.requestRoutines()
    }

    public func getExtras() -> Single<[ExtrasModel]> {
        return networkService.requestExtras()
    }
    
    public init(networkService: HomeService) {
        self.networkService = networkService
    }
}
