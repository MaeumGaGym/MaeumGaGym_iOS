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
        let loadProfile: Driver<String>
        let clickProfileButton: Observable<Void>
        let clickTargetButton: Observable<Void>
    }

    public struct Output {
        let profileData: Observable<SelfCareDetailProfileModel>
    }
    
    let profileSubject = PublishSubject<SelfCareDetailProfileModel>()
    
    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        
        let output = Output(profileData: profileSubject.asObservable())
        
        bindOutput(output: output)
        
        input.loadProfile
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, nickName in
                owner.useCase.getProfileData(nickName: nickName)
            }).disposed(by: disposeBag)
        
        input.clickProfileButton
            .subscribe(onNext: {
                SelfCareStepper.shared.steps.accept(MGStep.myProfileRequired)
            }).disposed(by: disposeBag)
        
        input.clickTargetButton
            .subscribe(onNext: {
                SelfCareStepper.shared.steps.accept(MGStep.targetHomeRequired)
            }).disposed(by: disposeBag)
        
        action(output)
        
        return output
    }
    
    private func bindOutput(output: Output) {
        useCase.profileData
            .subscribe(onNext: { data in
                self.profileSubject.onNext(data)
            }).disposed(by: disposeBag)
    }

}
