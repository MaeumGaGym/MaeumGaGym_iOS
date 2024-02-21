import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

import Core

public class SelfCareMyRoutineViewModel: BaseViewModel {

    private let disposeBag = DisposeBag()

    private let useCase: SelfCareUseCase

    public struct Input {
        let getMyRoutineData: Driver<Void>
    }

    public struct Output {
        let myRoutineData: Observable<SelfCareMyRoutineModel>
    }

    private let myRoutineDataSubject = PublishSubject<SelfCareMyRoutineModel>()

    public init(useCase: SelfCareUseCase) {
        self.useCase = useCase
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let output = Output(
            myRoutineData: myRoutineDataSubject.asObservable()
        )

        action(output)

        self.bindOutput(output: output)

        input.getMyRoutineData
            .drive(onNext: { [weak self] _ in
                self?.useCase.getMyRoutineData()
            }).disposed(by: disposeBag)

        return output
    }

    private func bindOutput(output: Output) {
        useCase.myRoutineData
            .subscribe(onNext: { myRoutineData in
                self.myRoutineDataSubject.onNext(myRoutineData)
            }).disposed(by: disposeBag)
    }
}



