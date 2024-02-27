import Foundation
import UIKit
import RxFlow
import RxCocoa

public class AppStepper: Stepper {
    public static let shared = AppStepper()
    
    public var steps = PublishRelay<Step>()
    
    public var initialStep: Step {
        return AppStep.initialization
    }
    
    public init(steps: PublishRelay<Step> = PublishRelay<Step>()) {
        self.steps = steps
    }
}
