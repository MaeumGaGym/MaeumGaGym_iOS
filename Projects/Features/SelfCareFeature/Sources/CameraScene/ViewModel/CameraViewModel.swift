import UIKit

import RxFlow
import RxCocoa
import RxSwift

import Core

public class CameraViewModel: BaseViewModel {
    
    public typealias ViewModel = CameraViewModel

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
