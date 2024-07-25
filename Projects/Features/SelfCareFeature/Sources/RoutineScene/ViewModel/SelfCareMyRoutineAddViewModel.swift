import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class SelfCareMyRoutineAddViewModel: BaseViewModel {

    public typealias ViewModel = SelfCareMyRoutineAddViewModel

    private let disposeBag = DisposeBag()

    private let useCase: SelfCareUseCase

    public struct Input {
        let getMyRoutineEditData: Driver<Void>
    }

    public struct Output {
        let myRoutineEditData: Observable<SelfCareMyRoutineEditModel>
    }

    private let myRoutineEditDataSubject = PublishSubject<SelfCareMyRoutineEditModel>()

    public init(useCase: SelfCareUseCase) {
        self.useCase = useCase
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let output = Output(
            myRoutineEditData: myRoutineEditDataSubject.asObservable()
        )

        action(output)

        self.bindOutput(output: output)

        input.getMyRoutineEditData
            .drive(onNext: { [weak self] _ in
                self?.useCase.getMyRoutineEditData()
            }).disposed(by: disposeBag)

        return output
    }

    private func bindOutput(output: Output) {
        useCase.myRoutineEditData
            .subscribe(onNext: { myRoutineEditData in
                self.myRoutineEditDataSubject.onNext(myRoutineEditData)
            }).disposed(by: disposeBag)
    }
}
