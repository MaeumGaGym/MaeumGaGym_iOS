import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class SelfCareDetailTargetViewModel: BaseViewModel {

    public typealias ViewModel = SelfCareDetailTargetViewModel

    private let disposeBag = DisposeBag()

    private let useCase: SelfCareUseCase

    public init(useCase: SelfCareUseCase) {
        self.useCase = useCase
    }

    public struct Input {
    }

    public struct Output {
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        return Output()
    }
}
