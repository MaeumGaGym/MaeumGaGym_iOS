import Foundation

import RxFlow
import RxCocoa

public class PostureStepper: Stepper {
    public static let shared = PostureStepper()

    public var steps = PublishRelay<Step>()

    public var initialStep: Step {
        return MGStep.postureMainIsRequired
    }

    public init() {

    }
}
