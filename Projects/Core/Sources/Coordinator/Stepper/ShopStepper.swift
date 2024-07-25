import Foundation

import RxFlow
import RxCocoa

public class ShopStepper: Stepper {
    public static let shared = ShopStepper()

    public var steps = PublishRelay<Step>()

    public var initialStep: Step {
        return MGStep.shopIsRequired
    }

    public init() {

    }
}
