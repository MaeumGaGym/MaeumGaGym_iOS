import UIKit

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class SelfCareProfileEditViewModel: BaseViewModel {

    public typealias ViewModel = SelfCareProfileEditViewModel
    
    private let disposeBag = DisposeBag()
    
    private let useCase: SelfCareUseCase
    
    public init(useCase: SelfCareUseCase) {
        self.useCase = useCase
    }

    public struct Input {
        let name: Driver<String>
        let height: Driver<String>
        let weight: Driver<String>
        let gender: Driver<String>
        let profileEditButtonClick: Driver<Void>
        let popVCButton: Driver<Void>
    }

    public struct Output { }
        
    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        
        let output = Output()
        
        let info = Driver.combineLatest(
            input.name,
            input.height,
            input.weight,
            input.gender
        )
        
        action(output)
        bindOutput(output: output)
        
        input.profileEditButtonClick
            .asObservable()
            .withLatestFrom(info)
            .subscribe(onNext: { [weak self] name, height, weight, gender in
                self?.useCase.requestProfileModify(
                    nickName: name,
                    height: Double(height) ?? 0,
                    weight: Double(weight) ?? 0,
                    gender: gender
                )
            }).disposed(by: disposeBag)
        
        input.popVCButton.asObservable()
            .subscribe(onNext: {
                SelfCareStepper.shared.steps.accept(MGStep.popRequired)
            }).disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output) { }

}
