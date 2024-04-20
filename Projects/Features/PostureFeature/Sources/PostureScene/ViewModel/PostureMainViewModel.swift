import UIKit

import RxSwift
import RxCocoa

import Core
import Domain

import MGLogger

public typealias PostureViewModelType = BaseViewModel

public class PostureMainViewModel: PostureViewModelType {
    
    public typealias ViewModel = PostureMainViewModel

    public var disposeBag: DisposeBag = DisposeBag()

    private let useCase: PostureUseCase

    public struct Input {
        let searchButtonTapped: Driver<Void>
    }

    public struct Output {
        let searchButtonTapped: Driver<Void>
    }

    public init(useCase: PostureUseCase) {
        self.useCase = useCase
    }

    public var onSettingButtonTap: (() -> Void)?

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {

        let output = Output(
            searchButtonTapped: input.searchButtonTapped.asDriver()
        )

        action(output)

        input.searchButtonTapped
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.onSettingButtonTap?()
                PostureStepper.shared.steps.accept(MGStep.postureSearchIsRequired)
            }).disposed(by: disposeBag)

        return output
    }
}
