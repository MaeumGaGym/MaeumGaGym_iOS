import Foundation
import RxFlow
import RxCocoa
import RxSwift
import Core

public class TimerViewModel: BaseViewModel {
    
    public typealias ViewModel = TimerViewModel

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
