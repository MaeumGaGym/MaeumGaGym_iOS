import Alamofire
import RxMoya
import Core

public enum APIType {
    
    case CSRFToken
    
    // Oauth
    case google
    case kakao
    case apple
}
