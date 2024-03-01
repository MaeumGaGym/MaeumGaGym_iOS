import RxFlow
import UIKit

public enum AppStep: Step {
    case tabBarIsRequired
    case homeIsRequired
    
    // posture
    case posture
    case postureIsRequired
    case selfCareIsRequired
    case shopIsRequired
    case startRequired
    
    //pickle
    case pickle
    case pickleRequired
    
    // home
    case home
    case homeStepRequired
    case homeBack
    case otherDestination
    
    // red
    case redViewRequired
    
    case initialization
    
    // selfCore
    case selfCoreHome
    case myProfileRequired
}
