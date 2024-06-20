import Alamofire
import RxMoya
import Core

public enum APIType {

    case auth
    case CSRFToken
    
    // Oauth
    case google
    case kakao
    case apple

    //Self Care
    case profile
    case routine
    case target
    case ounwan

    // Pose
    case posture
}
