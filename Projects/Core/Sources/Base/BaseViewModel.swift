import UIKit
import RxSwift
import RxCocoa
import RxFlow

public protocol BaseViewModel {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input, action: (Output) -> Void) -> Output
}
