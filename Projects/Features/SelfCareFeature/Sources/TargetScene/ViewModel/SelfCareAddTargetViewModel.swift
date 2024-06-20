import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class SelfCareAddTargetViewModel: BaseViewModel {
    
    public typealias ViewModel = SelfCareAddTargetViewModel
    
    private let disposeBag = DisposeBag()
    
    private let useCase: SelfCareUseCase
    
    public init(useCase: SelfCareUseCase) {
        self.useCase = useCase
    }
    
    public struct Input {
        let title: Driver<String>
        let startDate: Driver<String>
        let endDate: Driver<String>
        let content: Driver<String>
        let addTargetButton: Driver<Void>
    }
    
    public struct Output {
        
    }
    
    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        
        let info = Driver.combineLatest(
            input.title,
            input.startDate,
            input.endDate,
            input.content
        )
        
        input.addTargetButton
            .asObservable()
            .withLatestFrom(info)
            .subscribe(onNext: { title, startDate, endDate, content in
                self.useCase.addTargetData(
                    title: title,
                    content: content,
                    startDate: startDate.changeDateFormatWithInput(input: .fullDateKorForCalendar, type: .fullDate) ?? ""
                    , endDate: endDate.changeDateFormatWithInput(input: .fullDateKorForCalendar, type: .fullDate) ?? ""
                )
            }).disposed(by: disposeBag)
        
        return Output()
    }
    
//    private func bindOutput(output: Output) {
//        useCase.myTargetData
//            .subscribe(onNext: { targetMainData in
//                self.targetMainDataSubject.onNext(targetMainData)
//            }).disposed(by: disposeBag)
//    }
//    
//    private func bindOutput(output: Output) {
//        useCase.addTargetData(title: <#T##String#>, content: <#T##String#>, startDate: <#T##String#>, endDate: <#T##String#>)
//    }
}
