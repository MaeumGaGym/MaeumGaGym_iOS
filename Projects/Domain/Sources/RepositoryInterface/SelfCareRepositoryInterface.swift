import UIKit

import RxSwift

import Moya

public protocol SelfCareRepositoryInterface {
    //MARK: Routine
    func getMyRoutineData() -> Single<SelfCareMyRoutineModel>
    func getMyRoutineDetailData() -> Single<
    SelfCareMyRoutineDetailModel>
    func getMyRoutineEditData() -> Single<SelfCareMyRoutineEditModel>

    //MARK: Target
    func getTargetMainData() -> Single<SelfCareTargetMainModel>
    func getTargetDetailData() -> Single<SelfCareTargetDetailModel>

    //MARK: Profile
    func getProfileData(accessToken: String, userName: String) -> Single<SelfCareDetailProfileModel>
    func requestProfileModify(accessToken: String, nickName: String, height: Double, weight: Double, gender: String) -> Single<Response>
    
}
