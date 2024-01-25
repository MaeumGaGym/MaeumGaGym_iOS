import UIKit
import HomeFeatureInterface
import RxFlow
import Core
import HomeFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        let viewController = HomeViewController()
        self.window = makeWindow(scene: scene)
        window?.configure(withRootViewController: viewController)
    }
}
