import UIKit

import RxSwift

public protocol SelfCareUseCase {
    var myRoutineData: PublishSubject<SelfCareMyRoutineModel> { get }

    func getMyRoutineData()
}

public class DefaultSelfCareUseCase {
    private let repository: SelfCareRepositoryInterface
    private let disposeBag = DisposeBag()

    public let myRoutineData = PublishSubject<SelfCareMyRoutineModel>()

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
}
