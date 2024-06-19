import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class SelfCareEditTargetViewModel: BaseViewModel {
    
    public typealias ViewModel = SelfCareEditTargetViewModel
    
    private let disposeBag = DisposeBag()
    
    private let useCase: SelfCareUseCase
    
    public init(useCase: SelfCareUseCase) {
        self.useCase = useCase
    }
    
    public struct Input {
        let id: Driver<Int>
        let title: Driver<String>
        let startDate: Driver<String>
        let endDate: Driver<String>
        let content: Driver<String>
        let editTargetButton: Driver<Void>
    }
    
    public struct Output {
        
    }
    
    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        
        let info = Driver.combineLatest(
            input.title,
            input.startDate,
            input.endDate,
            input.content,
            input.id
        )
        
        input.editTargetButton
            .asObservable()
            .withLatestFrom(info)
            .subscribe(onNext: { title, startDate, endDate, content, id in
                self.useCase.modifyTargetData(
                    title: title,
                    content: content,
                    startDate: startDate.changeDateFormatWithInput(input: .fullDateKorForCalendar, type: .fullDate) ?? "", endDate: endDate.changeDateFormatWithInput(input: .fullDateKorForCalendar, type: .fullDate) ?? "",
                    id: id
                )
                SelfCareStepper.shared.steps.accept(MGStep.detailTargetRequired(id: id))
            }).disposed(by: disposeBag)
        
        return Output()
    }
    
}
