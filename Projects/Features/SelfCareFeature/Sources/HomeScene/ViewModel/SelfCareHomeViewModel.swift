import UIKit

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class SelfCareHomeViewModel: BaseViewModel {
    
    public typealias ViewModel = SelfCareHomeViewModel
    
    private let disposeBag = DisposeBag()
    
    private let useCase: SelfCareUseCase
    
    public init(useCase: SelfCareUseCase) {
        self.useCase = useCase
    }

    public struct Input {
        let loadProfile: Driver<Void>
        let clickProfileButton: Observable<String>
        let clickRoutineButton: Observable<Void>
        let clickTargetButton: Observable<Void>
        let clickMealButton: Observable<Void>
        let clickTodayExeButton: Observable<Void>
    }

    public struct Output {
        let profileData: Observable<SelfCareProfileInfoModel>
    }
    
    let profileSubject = PublishSubject<SelfCareProfileInfoModel>()
    
    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        
        let output = Output(profileData: profileSubject.asObservable())
        
        bindOutput(output: output)
        
        input.loadProfile
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, nickName in
                owner.useCase.getProfileInfoData()
            }).disposed(by: disposeBag)
        
        input.clickProfileButton
            .subscribe(onNext: { nickname in
                SelfCareStepper.shared.steps.accept(MGStep.myProfileRequired(nickname: nickname))
            }).disposed(by: disposeBag)
        
        input.clickRoutineButton
            .subscribe(onNext: {
                SelfCareStepper.shared.steps.accept(MGStep.myRoutineRequired)
            }).disposed(by: disposeBag)
        
        input.clickTargetButton
            .subscribe(onNext: {
                SelfCareStepper.shared.steps.accept(MGStep.targetHomeRequired)
            }).disposed(by: disposeBag)
        
        input.clickMealButton
            .subscribe(onNext: {
                SelfCareStepper.shared.steps.accept(MGStep.devRequired)
            }).disposed(by: disposeBag)
        
        input.clickTodayExeButton
            .subscribe(onNext: {
                SelfCareStepper.shared.steps.accept(MGStep.devRequired)
            }).disposed(by: disposeBag)
        
        action(output)
        
        return output
    }
    
    private func bindOutput(output: Output) {
        useCase.profileInfoData
            .subscribe(onNext: { data in
                self.profileSubject.onNext(data)
            }).disposed(by: disposeBag)
    }
}
