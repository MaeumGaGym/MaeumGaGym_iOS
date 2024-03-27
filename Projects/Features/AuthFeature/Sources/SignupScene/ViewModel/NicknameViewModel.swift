import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

import MGNetworks

public class NicknameViewModel: BaseViewModel {

    public typealias ViewModel = NicknameViewModel

    private let useCase: AuthUseCase

    public var disposeBag: DisposeBag = DisposeBag()

    public struct Input {
        let navButtonTap: Driver<Void>
        let nextButtonTap: Driver<Void>
    }

    public struct Output {
        let navButtonTap: Driver<Void>
        let nextButtonTap: Driver<Void>
    }

    public init(useCase: AuthUseCase) {
        self.useCase = useCase
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {

        let output = Output(navButtonTap: input.navButtonTap.asDriver(), nextButtonTap: input.nextButtonTap.asDriver())

        action(output)
        return output
    }
}
