import UIKit
import HomeFeatureInterface
import RxFlow
import Core

import Data
import Domain
import MGNetworks

import HomeFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator = FlowCoordinator()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
            window?.rootViewController = TimerViewController(TimerViewModel())
        window?.makeKeyAndVisible()
    }
}
