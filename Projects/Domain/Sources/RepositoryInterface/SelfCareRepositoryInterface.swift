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
    func getMyTarget(accessToken: String) -> Single<SelfCareTargetMainModel>
    func addTarget(accessToken: String, title: String, content: String, startDate: String, endDate: String) -> Single<Response>
    func modifyTarget(accessToken: String, title: String, content: String, startDate: String, endDate: String, id: Int) -> Single<Response>
    func deleteTarget(accessToken: String, id: Int) -> Single<Response>

    //MARK: Profile
    func getProfileData(accessToken: String, userName: String) -> Single<SelfCareDetailProfileModel>
    func requestProfileModify(accessToken: String, nickName: String, height: Double, weight: Double, gender: String) -> Single<Response>
    
}
