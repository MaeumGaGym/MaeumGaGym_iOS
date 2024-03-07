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
    case postureMainIsRequired
    case postureDetailIsRequired(withDetailId: Int)
    case postureSearchIsRequired

    // posture - tab
    case postureRecommandIsRequired
    case postureChestIsRequired
    case postureBackIsRequired
    case postureShoulderIsRequired
    case postureArmIsRequired
    case postureStomachIsRequired
    case postureFrontlegIsRequired

    //pickle
    case pickle
    case pickleRequired
    
    // red
    case redViewRequired
    
    case initialization
    
    // selfCore
    case selfCoreHome
    case myProfileRequired
    
    case postureIsRequired
    case shopIsRequired
    case selfCareIsRequired
}
