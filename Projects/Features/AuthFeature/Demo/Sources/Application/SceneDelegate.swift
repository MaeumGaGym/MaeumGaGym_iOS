import UIKit

import RxFlow

import Core
import Domain
import Data

import MGFlow
import MGNetworks
import AuthFeature

import KakaoSDKAuth
import TokenManager
import AuthFeatureInterface

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator = FlowCoordinator()
    var mainFlow: AuthFlow!

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            handleURL(url)
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }

        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        configureMainFlow()
        window?.makeKeyAndVisible()
    }

    private func handleURL(_ url: URL) {
        if AuthApi.isKakaoTalkLoginUrl(url) {
            _ = AuthController.handleOpenUrl(url: url)
        }
    }

    private func configureMainFlow() {
        mainFlow = AuthFlow()
        coordinator.coordinate(flow: mainFlow, with: OneStepper(withSingleStep: MGStep.authSplashIsRequired))
        Flows.use(mainFlow, when: .created) { [weak self] root in
            self?.window?.rootViewController = root
        }
    }
}
