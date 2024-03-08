import UIKit
import ShopFeature
import RxFlow
import RxSwift
import RxCocoa
import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator = FlowCoordinator()
    var disposeBag = DisposeBag()

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene

        let stepper = TestAppStepper()
        let initFlow = InitFlow()

        coordinator.coordinate(flow: initFlow, with: stepper)
        Flows.use(initFlow, when: .created) { root in
            self.window?.backgroundColor = UIColor.white
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
