import Foundation
import UIKit

import RxFlow
import RxCocoa
import RxSwift

public class AppStepper: Stepper {
    public static let shared = AppStepper()
    
    public var steps = PublishRelay<Step>()
    
    public var initialStep: Step {
        return MGStep.initialization
    }
    
    public init() {
    
    }
}
