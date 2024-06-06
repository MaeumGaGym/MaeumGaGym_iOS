import UIKit

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class SelfCareProfileViewModel: BaseViewModel {
    
    public typealias ViewModel = SelfCareProfileViewModel
    
    private let disposeBag = DisposeBag()
    
    private let useCase: SelfCareUseCase
    
    public struct Input {
        let getProfileData: Driver<Void>
    }
    
    public struct Output {
        var profileData: Observable<SelfCareDetailProfileModel>
    }
    
    private let profileDataSubject = PublishSubject<SelfCareDetailProfileModel>()
    
    public init(useCase: SelfCareUseCase) {
        self.useCase = useCase
    }
    
    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let output = Output(
            profileData:
                profileDataSubject.asObservable()
        )
        
        action(output)
        
        self.bindOutput(output: output)
        
        input.getProfileData
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, dd in
                owner.useCase.getProfileData()
            }).disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output) {
        useCase.profileData
            .subscribe(onNext: { profileData in
                self.profileDataSubject.onNext(profileData)
            }).disposed(by: disposeBag)
    }
    
}
