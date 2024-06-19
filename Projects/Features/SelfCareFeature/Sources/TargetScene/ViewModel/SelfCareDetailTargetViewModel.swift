import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class SelfCareDetailTargetViewModel: BaseViewModel {

    public typealias ViewModel = SelfCareDetailTargetViewModel

    private let disposeBag = DisposeBag()

    private let useCase: SelfCareUseCase

    public init(useCase: SelfCareUseCase) {
        self.useCase = useCase
    }

    public struct Input {
        let loadDetailTargetData: Driver<Int>
        let popVCButton: Driver<Void>
    }

    public struct Output {
        let detailTargetData: Observable<TargetContentModel>
    }
    
    let detailTargetData = PublishSubject<TargetContentModel>()

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let output = Output(detailTargetData: detailTargetData.asObservable())

        action(output)

        self.bindOutput(output: output)
        
        input.loadDetailTargetData
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, id in
                owner.useCase.getTargetDetailData(id: id)
            }).disposed(by: disposeBag)
        
        input.popVCButton
            .asObservable()
            .subscribe(onNext: {
                SelfCareStepper.shared.steps.accept(MGStep.popRequired)
            }).disposed(by: disposeBag)

        return output
    }

    private func bindOutput(output: Output) {
        useCase.targetDetailData
            .subscribe(onNext: { targetDetailData in
                self.detailTargetData.onNext(targetDetailData)
            }).disposed(by: disposeBag)
        
    }
}
