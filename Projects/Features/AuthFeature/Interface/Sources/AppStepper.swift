import Foundation
import RxFlow
import RxCocoa
import Core
import RxSwift

public class AppStepper: Stepper {

    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    public init() {
    }

    public var initialStep: Step {
        return AppStep.startRequired
    }
}
