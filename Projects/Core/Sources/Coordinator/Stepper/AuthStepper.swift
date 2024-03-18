import Foundation

import RxFlow
import RxCocoa

public class AuthStepper: Stepper {
    public static let shared = AuthStepper()

    public var steps = PublishRelay<Step>()

    public var initialStep: Step {
        return MGStep.authIntroIsRequired
    }

    public init() {

    }
}
