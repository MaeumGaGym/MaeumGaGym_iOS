import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain

public class CompleteViewModel: BaseViewModel {

    public typealias ViewModel = CompleteViewModel
    
    public var disposeBag: DisposeBag
    
    private let useCase: AuthUseCase

    public struct Input {
        let checkButtonTapped: Driver<Void>
    }

    public struct Output {

    }

    public init(authUseCase: AuthUseCase) {
        self.useCase = authUseCase
        self.disposeBag = DisposeBag()
    }
    
    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        
        input.checkButtonTapped
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.useCase.completeButtonTap()
            }).disposed(by: disposeBag)
        
        return Output()
    }
}
