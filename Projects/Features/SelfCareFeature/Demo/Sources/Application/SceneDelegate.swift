import UIKit

import RxFlow

import SelfCareFeature
import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
            
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: SelfCareMyRoutineEditViewController(SelfCareMyRoutineEditViewModel()))
        window?.makeKeyAndVisible()
    }
}
