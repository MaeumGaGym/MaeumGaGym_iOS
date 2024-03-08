import Foundation
import RxFlow
import RxCocoa

public class HomeStepper: Stepper {
    public static let shared = HomeStepper()
    
    public var steps = PublishRelay<Step>()
    
    public var initialStep: Step {
        return MGStep.home
    }
    
    public init() {
        
    }
}
