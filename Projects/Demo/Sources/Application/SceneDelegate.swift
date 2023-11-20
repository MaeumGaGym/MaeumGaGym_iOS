import UIKit
import RxFlow
import RootFeature
import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var coordinator = FlowCoordinator()
    var mainFlow: AppFlow!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        mainFlow = AppFlow()

        Flows.use(mainFlow, when: .created) { root in
            self.window?.rootViewController = root
        }

        coordinator.coordinate(flow: mainFlow, with: OneStepper(withSingleStep: AppStep.startRequired))

        window?.makeKeyAndVisible()
    }
}

