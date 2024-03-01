import UIKit
import MGFlow
import RxFlow
import RootFeature
import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var coordinator = FlowCoordinator()
    var mainFlow: InitFlow!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let mainViewController = UIViewController()
        
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.view.backgroundColor = .red

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}

