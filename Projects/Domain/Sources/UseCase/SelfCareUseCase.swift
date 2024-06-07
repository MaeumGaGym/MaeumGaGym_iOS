import UIKit

import RxSwift
import RxCocoa

import Core
import Moya

import MGLogger
import TokenManager

public protocol SelfCareUseCase {
    //MARK: Routine
    var myRoutineData: PublishSubject<SelfCareMyRoutineModel> { get }
    var myRoutineDetailData: PublishSubject<SelfCareMyRoutineDetailModel> { get }
    var myRoutineEditData: PublishSubject<SelfCareMyRoutineEditModel> { get }

    func getMyRoutineData()
    func getMyRoutineDetailData()
    func getMyRoutineEditData()

    //MARK: Target
    var myTargetData: PublishSubject<SelfCareTargetMainModel> { get }
    var targetDetailData: PublishSubject<SelfCareTargetDetailModel> { get }

    func getMyTargetData()
//    func getTargetDetailData()
    func addTargetData(title: String, content: String, startDate: String, endDate: String)
    func modifyTargetData(title: String, content: String, startDate: String, endDate: String, id: Int)
    func deleteTargetData(id: Int)
    
    //MARK: Profile
    var profileData: PublishSubject<SelfCareDetailProfileModel> { get }
    
    func getProfileData(nickName: String)
    func requestProfileModify(nickName: String, height: Double, weight: Double, gender: String)
}

public class DefaultSelfCareUseCase {
    private let repository: SelfCareRepositoryInterface
    private let disposeBag = DisposeBag()

    public let myRoutineData = PublishSubject<SelfCareMyRoutineModel>()
    public let myRoutineDetailData = PublishSubject<SelfCareMyRoutineDetailModel>()
    public let myRoutineEditData = PublishSubject<SelfCareMyRoutineEditModel>()

    public let myTargetData = PublishSubject<SelfCareTargetMainModel>()
    public let targetDetailData = PublishSubject<SelfCareTargetDetailModel>()
    
    public let profileData = PublishSubject<SelfCareDetailProfileModel>()

    public init(repository: SelfCareRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultSelfCareUseCase: SelfCareUseCase {
    
    public func getMyRoutineData() {
        repository.getMyRoutineData()
            .subscribe(onSuccess: { [weak self] myRoutineData in
                self?.myRoutineData.onNext(myRoutineData)
            },
                       onFailure: { error in
                print("SelfCareUseCase getMyRoutineData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getMyRoutineDetailData() {
        repository.getMyRoutineDetailData()
            .subscribe(onSuccess: { [weak self] myRoutineDetailData in
                self?.myRoutineDetailData.onNext(myRoutineDetailData)
            },
                       onFailure: { error in
                print("SelfCareUseCase getMyRoutineDetailData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getMyRoutineEditData() {
        repository.getMyRoutineEditData()
            .subscribe(onSuccess: { [weak self] myRoutineEditData in
                self?.myRoutineEditData.onNext(myRoutineEditData)
            },
                       onFailure: { error in
                print("SelfCareUseCase getMyRoutineEditData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getMyTargetData() {
        guard let token = TokenManagerImpl().get(key: .accessToken) else {
            return
        }
        repository.getMyTarget(accessToken: token)
            .subscribe(onSuccess: { [weak self] targetMainData in
                self?.myTargetData.onNext(targetMainData)
            },
                       onFailure: { error in
                print("SelfCareUseCase getMyTargetData error occured: \(error)")
            }).disposed(by: disposeBag)
    }
    
//    public func getTargetDetailData() {
//        <#code#>
//    }
    public func addTargetData(title: String, content: String, startDate: String, endDate: String) {
        guard let token = TokenManagerImpl().get(key: .accessToken) else {
            return
        }
        
        repository.addTarget(accessToken: token, title: title, content: content, startDate: startDate, endDate: endDate)
            .subscribe(onSuccess: { [weak self] data in
                print("profileData: \(data)")
            }, onFailure: { error in
                print("SelfCareUseCase addTarget error occured: \(error)")
            }).disposed(by: disposeBag)

    }
    public func modifyTargetData(title: String, content: String, startDate: String, endDate: String, id: Int) {
        guard let token = TokenManagerImpl().get(key: .accessToken) else {
            return
        }
        repository.modifyTarget(accessToken: token, title: title, content: content, startDate: startDate, endDate: endDate, id: id)
            .subscribe(onSuccess: { [weak self] data in
                print("profileData: \(data)")
            }, onFailure: { error in
                print("SelfCareUseCase modifyTargetData error occured: \(error)")
            }).disposed(by: disposeBag)

    }
    public func deleteTargetData(id: Int) {
        guard let token = TokenManagerImpl().get(key: .accessToken) else {
            return
        }
        repository.deleteTarget(accessToken: token, id: id)
            .subscribe(onSuccess: { [weak self] data in
                print("profileData: \(data)")
            }, onFailure: { error in
                print("SelfCareUseCase deleteTargetData error occured: \(error)")
            }).disposed(by: disposeBag)

    }
    
    public func getProfileData(nickName: String) {
        guard let token = TokenManagerImpl().get(key: .accessToken) else {
            return
        }
        repository.getProfileData(accessToken: token, userName: nickName)
            .subscribe(onSuccess: { [weak self] profileData in
                print("profileData: \(profileData)")
                self?.profileData.onNext(profileData)
            }, onFailure: { error in
                print("SelfCareUseCase getProfileData error occured: \(error)")
            }).disposed(by: disposeBag)
    }
    
    public func requestProfileModify(nickName: String, height: Double, weight: Double, gender: String) {
        guard let token = TokenManagerImpl().get(key: .accessToken) else { return }
        repository.requestProfileModify(accessToken: token, nickName: nickName, height: height, weight: weight, gender: gender)
            .subscribe(onSuccess: { [weak self] _ in
                print("success")
            }, onFailure: { error in
                    print("SelfCareUseCase getTargetDetailData error occured: \(error)")
            }).disposed(by: disposeBag)
        }

}
