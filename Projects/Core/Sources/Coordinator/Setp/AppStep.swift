import RxFlow
import UIKit

public enum MGStep: Step {
    
    // home - main
    case home
    case homeStepRequired
    case homeRoutineRequired
    case homeTimerRequired
    case homeMetronomeRequired
    case homeWakaTimerRequired
    case homeCalculatorRequired
    case homeSettingRequired
    case homeIsRequired
    case homeBack
    
    // home - timer
    case homeTimerAddRequired
    case homeTimerAddCancelRequired
    
    // home - Metronome
    case homeMetronomeSettingRequired
    case homeMetronomeBitSoundRequired
        
    // posture
    case posture
    case postureIsRequired
    case selfCareIsRequired
    case shopIsRequired
    case startRequired
    
    //pickle
    case pickle
    case pickleRequired
    
    // red
    case redViewRequired
    
    case initialization
    
    // selfCore
    case selfCoreHome
    case myProfileRequired
}
