import RxSwift

import Moya

import Domain
import MGNetworks

public class SelfCareRepository: SelfCareRepositoryInterface {

    private let networkService: DefaultSelfCareService

    public func getMyRoutineData() -> Single<SelfCareMyRoutineModel> {
        return networkService.getMyRoutineData()
    }

    public func getMyRoutineDetailData() -> Single<SelfCareMyRoutineDetailModel> {
        return networkService.getMyRoutineDetailData()
    }

    public func getMyRoutineEditData() -> Single<SelfCareMyRoutineEditModel> {
        return networkService.getMyRoutineEditData()
    }

    public func getTargetMainData() -> Single<SelfCareTargetMainModel> {
        return networkService.getTargetMainData()
    }

    public func getTargetDetailData() -> Single<SelfCareTargetDetailModel> {
        return networkService.getTargetDetailData()
    }

    public func getProfileData(accessToken: String, userName: String) -> Single<SelfCareDetailProfileModel> {
        return networkService.getProfileData(accessToken: accessToken, userName: userName)
    }
    
    public func requestProfileModify(accessToken: String, nickName: String, height: Double, weight: Double, gender: String) -> Single<Response> {
        return networkService.requestProfileModify(accessToken: accessToken, nickName: nickName, height: height, weight: weight, gender: gender)
    }

    public init(networkService: DefaultSelfCareService) {
        self.networkService = networkService
    }
}
