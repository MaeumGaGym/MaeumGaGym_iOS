import UIKit

import RxSwift

public protocol SelfCareUseCase {
    var myRoutineData: PublishSubject<SelfCareMyRoutineModel> { get }
    var myRoutineDetailData: PublishSubject<SelfCareMyRoutineDetailModel> { get }
    var myRoutineEditData: PublishSubject<SelfCareMyRoutineEditModel> { get }

    var targetMainData: PublishSubject<SelfCareTargetMainModel> { get }
    var targetDetailData: PublishSubject<SelfCareTargetDetailModel> { get }

    func getMyRoutineData()
    func getMyRoutineDetailData()
    func getMyRoutineEditData()

    func getTargetMainData()
    func getTargetDetailData()
}

public class DefaultSelfCareUseCase {
    private let repository: SelfCareRepositoryInterface
    private let disposeBag = DisposeBag()

    public let myRoutineData = PublishSubject<SelfCareMyRoutineModel>()
    public let myRoutineDetailData = PublishSubject<SelfCareMyRoutineDetailModel>()
    public let myRoutineEditData = PublishSubject<SelfCareMyRoutineEditModel>()

    public let targetMainData = PublishSubject<SelfCareTargetMainModel>()
    public let targetDetailData = PublishSubject<SelfCareTargetDetailModel>()

    public init(repository: SelfCareRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultSelfCareUseCase: SelfCareUseCase {

    public func getMyRoutineData() {
        repository.getMyRoutineData()
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, myRoutineData in
                owner.myRoutineData.onNext(myRoutineData)
            }, onError: { error in
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
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, myRoutineData in
                owner.myRoutineEditData.onNext(myRoutineData)
            }, onError: { error in
                print("SelfCareUseCase getMyRoutineEditData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getTargetMainData() {
        repository.getTargetMainData()
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, targetMainData in
                owner.targetMainData.onNext(targetMainData)
            }, onError: { error in
                print("SelfCareUseCase getTargetMainData error occured: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getTargetDetailData() {
        repository.getTargetDetailData()
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, targetDetailData in
                owner.targetDetailData.onNext(targetDetailData)
            }, onError: { error in
                print("SelfCareUseCase getTargetDetailData error occured: \(error)")
            }).disposed(by: disposeBag)
    }
}
