import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class SelfCareTargetMainViewModel: BaseViewModel {

    public typealias ViewModel = SelfCareTargetMainViewModel

    private let disposeBag = DisposeBag()

    private let useCase: SelfCareUseCase

    public struct Input {
        let getTargetMainData: Driver<Void>
    }

    public struct Output {
        let targetMainData: Observable<SelfCareTargetMainModel>
    }

    private let targetMainDataSubject = PublishSubject<SelfCareTargetMainModel>()

    public init(useCase: SelfCareUseCase) {
        self.useCase = useCase
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let output = Output(
            targetMainData: targetMainDataSubject.asObservable()
        )

        action(output)

        self.bindOutput(output: output)

        input.getTargetMainData
            .drive(onNext: { [weak self] _ in
                self?.useCase.getMyTargetData()
            }).disposed(by: disposeBag)

        return output
    }

    private func bindOutput(output: Output) {
        useCase.myTargetData
            .subscribe(onNext: { targetMainData in
                self.targetMainDataSubject.onNext(targetMainData)
            }).disposed(by: disposeBag)
    }
}
