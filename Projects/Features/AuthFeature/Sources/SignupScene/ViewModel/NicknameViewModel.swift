import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain

public class NicknameViewModel: BaseViewModel {
    
    public typealias ViewModel = NicknameViewModel
    
    private let useCase: AuthUseCase

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        return Output()
    }

    public struct Input {

    }

    public struct Output {

    }

    public init(useCase: AuthUseCase) {
        self.useCase = useCase
    }
}
