import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class SelfCareMyRoutineDetailViewModel: BaseViewModel {
    
    private let disposeBag = DisposeBag()

    private let useCase: SelfCareUseCase

    public struct Input {
        let getMyRoutineDetailData: Driver<Void>
    }

    public struct Output {
        let myRoutineDetailData: Observable<SelfCareMyRoutineDetailModel>
    }

    private let myRoutineDetailDataSubject = PublishSubject<SelfCareMyRoutineDetailModel>()

    public init(useCase: SelfCareUseCase) {
        self.useCase = useCase
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let output = Output(
            myRoutineDetailData: myRoutineDetailDataSubject.asObservable()
        )

        action(output)

        self.bindOutput(output: output)

        input.getMyRoutineDetailData
            .drive(onNext: { [weak self] _ in
                self?.useCase.getMyRoutineDetailData()
            }).disposed(by: disposeBag)

        return output
    }

    private func bindOutput(output: Output) {
        useCase.myRoutineDetailData
            .subscribe(onNext: { myRoutineDetailData in
                self.myRoutineDetailDataSubject.onNext(myRoutineDetailData)
            }).disposed(by: disposeBag)
    }
}
