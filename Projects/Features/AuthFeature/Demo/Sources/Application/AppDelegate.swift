import UIKit

import KakaoSDKCommon
import KakaoSDKAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        if (AuthApi.isKakaoTalkLoginUrl(url)) {
//            return AuthController.handleOpenUrl(url: url)
//        }
//        return false
//    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KakaoSDK.initSDK(appKey: "dcfcd3ab4a997c5a53e2ab26a8ec2a63")
        return true
    }
}
