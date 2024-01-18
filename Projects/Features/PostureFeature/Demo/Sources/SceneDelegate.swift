import UIKit
import RxFlow
import Core
import PostureFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator = FlowCoordinator()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
//        window?.rootViewController = UINavigationController(rootViewController: PostureDetailViewController(PostureDetailViewModel()))
            window?.rootViewController = UINavigationController(rootViewController: PostureRecommandViewController(PostureViewModel()))
        window?.makeKeyAndVisible()
    }
}
