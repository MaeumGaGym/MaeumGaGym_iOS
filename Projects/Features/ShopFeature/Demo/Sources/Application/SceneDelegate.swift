import UIKit
import ShopFeature
import RxFlow
import RxSwift
import RxCocoa
import Core
import MGFlow


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator = FlowCoordinator()
    var mainFlow: ShopFlow!

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene

        let mainFlow = ShopFlow()

        coordinator.coordinate(flow: mainFlow, with: OneStepper(withSingleStep: MGStep.shopIsRequired))
        
        Flows.use(mainFlow, when: .created) { root in
            self.window?.rootViewController = root
            self.window?.makeKey()
        }
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
