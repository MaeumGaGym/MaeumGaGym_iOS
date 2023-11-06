import Foundation
import RxFlow
import RxCocoa
import RxSwift
import Core

class LoginStepper: Stepper {

    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    init() {
    }

    var initialStep: Step {
        return AppStep.loginIsRequired
    }
}

class HomeStepper: Stepper {

    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    init() {
    }

    var initialStep: Step {
        return AppStep.homeIsRequired
    }
}

