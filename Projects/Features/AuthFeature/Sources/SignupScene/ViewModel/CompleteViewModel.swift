import Foundation
import RxFlow
import RxCocoa
import RxSwift
import Core

public class CompleteViewModel: BaseViewModel {

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        return Output()
    }

    public struct Input {

    }
    
    public struct Output {

    }

    public init() {

    }
}


