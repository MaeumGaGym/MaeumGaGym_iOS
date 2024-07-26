import Foundation

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

    public func getMyTarget(accessToken: String, page: Int) -> Single<SelfCareTargetMainModel> {
        return networkService.getMyTarget(accessToken: accessToken, page: page)
            .map(SelfCareTargetDTO.self)
            .map { $0.toDomain() }
    }
    
    public func getMonthTarget(accessToken: String, date: String) -> Single<SelfCareTargetMainModel> {
        return networkService.getMonthTarget(accessToken: accessToken, date: date)
            .map(SelfCareTargetDTO.self)
            .map { $0.toDomain() }
    }

    public func getTargetDetailData(accessToken: String, id: Int) -> Single<TargetContentModel> {
        return networkService.getDetailTarget(accessToken: accessToken, id: id)
            .map(SelfCareTargetDTOElement.self)
            .map { $0.toDomain() }
    }
    
    public func addTarget(accessToken: String, title: String, content: String, startDate: String, endDate: String) -> Single<Response> {
        return networkService.addTarget(accessToken: accessToken, title: title, content: content, startDate: startDate, endDate: endDate)
    }
    public func modifyTarget(accessToken: String, title: String, content: String, startDate: String, endDate: String, id: Int) -> Single<Response> {
        return networkService.modifyTarget(accessToken: accessToken, title: title, content: content, startDate: startDate, endDate: endDate, id: id)
    }
    public func deleteTarget(accessToken: String, id: Int) -> Single<Response> {
        return networkService.deleteTarget(accessToken: accessToken, id: id)
    }

    public func getProfileData(accessToken: String, userName: String) -> Single<SelfCareDetailProfileModel> {
        return networkService.getProfileData(accessToken: accessToken, userName: userName)
            .map(SelfCareProfileDTO.self)
            .map { $0.toDomain() }
    }
    
    public func requestProfileModify(accessToken: String, nickName: String, height: Double, weight: Double, gender: String) -> Single<Response> {
        return networkService.requestProfileModify(accessToken: accessToken, nickName: nickName, height: height, weight: weight, gender: gender)
    }
    
    public func requestInfoShow(accessToken: String) -> Single<SelfCareProfileInfoModel> {
        return networkService.requestProfileInfo(accessToken: accessToken)
            .map(SelfCareProfileInfoDTO.self)
            .map { $0.toDomain() }
    }
    
    public func requestUserDel(accessToken: String) -> Single<Response> {
        return networkService.requestUserDel(accessToken: accessToken)
    }

    public init(networkService: DefaultSelfCareService) {
        self.networkService = networkService
    }
}
