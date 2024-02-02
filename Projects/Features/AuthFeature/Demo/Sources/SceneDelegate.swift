import UIKit
import AuthFeatureInterface
import RxFlow
import Core
import AuthFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.configure(withRootViewController: SignUpViewController(CompleteViewModel()))
        window?.makeKeyAndVisible()
    }
}
