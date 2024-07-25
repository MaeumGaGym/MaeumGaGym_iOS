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
        let deleteTarget: Driver<Int>
        let editTarget: Driver<Int>
//        let moveToDetailTarget: Driver<Int>
        let popVCButton: Driver<Void>
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
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, targetData in
                owner.useCase.getMyTargetData(page: 0)
            }).disposed(by: disposeBag)
        
        input.deleteTarget
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, id in
                owner.useCase.deleteTargetData(id: id)
            }).disposed(by: disposeBag)
        
        input.editTarget
            .asObservable()
            .subscribe(onNext: { id in
                SelfCareStepper.shared.steps.accept(MGStep.modifyTargetRequired(id: id))
            }).disposed(by: disposeBag)

        
//        input.moveToDetailTarget
//            .asObservable()
//            .withUnretained(self)
//            .subscribe(onNext: { owner, id in
//                SelfCareStepper.shared.steps.accept(MGStep.detailTargetRequired(id: id))
//            }).disposed(by: disposeBag)
        
        input.popVCButton
            .asObservable()
            .subscribe(onNext: {
                SelfCareStepper.shared.steps.accept(MGStep.popRequired)
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
