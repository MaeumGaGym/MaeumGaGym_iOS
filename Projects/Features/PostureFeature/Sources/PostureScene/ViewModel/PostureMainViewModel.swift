import UIKit

import RxSwift
import RxCocoa

import Core
import Domain
import HomeFeatureInterface

import MGLogger

public class PostureMainViewModel: HomeViewModelType {
    
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
            .drive(onNext: { [weak self] _ in
                self?.onSettingButtonTap?()
                PostureStepper.shared.steps.accept(MGStep.postureSearchIsRequired)
                MGLogger.debug("searchButtonTapped")
            }).disposed(by: disposeBag)

        return output
    }
}
