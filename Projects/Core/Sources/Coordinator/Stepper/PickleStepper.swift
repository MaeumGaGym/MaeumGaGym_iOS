import Foundation
import RxFlow
import RxCocoa

public class PickleStepper: Stepper {
    public static let shared = PickleStepper()
    
    public var steps = PublishRelay<Step>()
    
    public var initialStep: Step {
        return MGStep.home
    }
    
    public init() {
        
    }
}
