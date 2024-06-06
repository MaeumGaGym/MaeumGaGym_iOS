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
    var targetMainData: PublishSubject<SelfCareTargetMainModel> { get }
    var targetDetailData: PublishSubject<SelfCareTargetDetailModel> { get }

    func getTargetMainData()
    func getTargetDetailData()
    
    //MARK: Profile
    var profileData: PublishSubject<SelfCareDetailProfileModel> { get }
    
    func getProfileData()
}

public class DefaultSelfCareUseCase {
    private let repository: SelfCareRepositoryInterface
    private let disposeBag = DisposeBag()

    public let myRoutineData = PublishSubject<SelfCareMyRoutineModel>()
    public let myRoutineDetailData = PublishSubject<SelfCareMyRoutineDetailModel>()
    public let myRoutineEditData = PublishSubject<SelfCareMyRoutineEditModel>()

    public let targetMainData = PublishSubject<SelfCareTargetMainModel>()
    public let targetDetailData = PublishSubject<SelfCareTargetDetailModel>()
    
    public let profileData = PublishSubject<SelfCareDetailProfileModel>()
    
    public var userNameText: String = ""

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

    public func getTargetMainData() {
        repository.getTargetMainData()
            .subscribe(onSuccess: { [weak self] targetMainData in
                self?.targetMainData.onNext(targetMainData)
            }, 
                       onFailure: { error in
                print("SelfCareUseCase getTargetMainData error occured: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getTargetDetailData() {
        repository.getTargetDetailData()
            .subscribe(onSuccess: { [weak self] targetDetailData in
                self?.targetDetailData.onNext(targetDetailData)
            }, onFailure: { error in
                print("SelfCareUseCase getTargetDetailData error occured: \(error)")
            }).disposed(by: disposeBag)
    }
    
    public func getProfileData() {
        guard let token = TokenManagerImpl().get(key: KeychainType.accessToken) else { return  }
        repository.getProfileData(accessToken: token, userName: userNameText)
            .subscribe(onSuccess: { [weak self] profileData in
                self?.profileData.onNext(profileData)
            }, onFailure: { error in
                print("SelfCareUseCase getTargetDetailData error occured: \(error)")
            }).disposed(by: disposeBag)
    }
}
