import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class NicknameViewModel: BaseViewModel {

    public typealias ViewModel = NicknameViewModel

    private let useCase: AuthUseCase
    
    public var disposeBag: DisposeBag = DisposeBag()

    public struct Input {
        let navButtonTap: Driver<Void>
        let nextButtonTap: Driver<String?>
    }

    public struct Output {
        let navButtonTap: Driver<Void>
        let nicknameState: Observable<Bool>
    }

    public init(useCase: AuthUseCase) {
        self.useCase = useCase
    }
    
    private let nicknameStateSubject = PublishSubject<Bool>()

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {

        let output = Output(navButtonTap: input.navButtonTap.asDriver(), nicknameState: nicknameStateSubject.asObservable())

        action(output)

        input.nextButtonTap
                .asObservable()
                .compactMap { $0 }
                .withUnretained(self)
                .subscribe(onNext: { owner, nickname in
                    owner.useCase.changeNickname(nickname: nickname)
                    owner.nicknameStateSubject.onNext(owner.useCase.nextButtonTap())
                }).disposed(by: disposeBag)

        return output
    }
}
