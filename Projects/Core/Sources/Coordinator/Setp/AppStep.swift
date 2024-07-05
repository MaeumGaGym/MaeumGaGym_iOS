import RxFlow
import UIKit

public enum MGStep: Step {
    
    // TabBar
    case TabBarIsRequired

    // Auth
    case authSplashIsRequired
    case authIntroIsRequired
    case authAgreeIsRequired
    case authNickNameIsRequired
    case authCompleteIsRequired
    case authBack
    
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
    case postureBack

    // posture - tab
    case postureRecommandIsRequired
    case postureChestIsRequired
    case postureBackIsRequired
    case postureShoulderIsRequired
    case postureArmIsRequired
    case postureStomachIsRequired
    case postureFrontlegIsRequired

    // pickle
    case pickle
    case pickleRequired
    
    // red
    case redViewRequired
    
    case initialization
    
    //MARK: selfCare
    case selfCoreHome
    case popRequired
    case devRequired
    
    //routine
    case myRoutineRequired
//    case
    
    //target
    case targetHomeRequired
    case addTargetRequired
    case modifyTargetRequired(id: Int)
    case detailTargetRequired(id: Int)
    case presentTargetAttribute
    
    //profile
    case myProfileRequired
    case editMyProfileRequired
    
    case postureIsRequired
    case shopIsRequired
    case selfCareIsRequired
}
