import Foundation

import RxFlow
import RxCocoa

public class SelfCareStepper: Stepper {
    public static let shared = SelfCareStepper()

    public var steps = PublishRelay<Step>()

    public var initialStep: Step {
        return MGStep.selfCoreHome
    }

    public init() {

    }
}
