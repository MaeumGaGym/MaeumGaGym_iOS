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

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    var coordinator = FlowCoordinator()
    var mainFlow: AuthFlow!

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene

        mainFlow = AuthFlow()

        coordinator.coordinate(flow: mainFlow, with: OneStepper(withSingleStep: MGStep.authSplashIsRequired))
        Flows.use(mainFlow, when: .created) { root in
            self.window?.rootViewController = root
            self.window?.makeKey()
        }
        window?.makeKeyAndVisible()
    }

//    private func coordinatorLogStart() {
//        coordinator.rx.willNavigate
//            .subscribe(onNext: { flow, step in
//                let currentFlow = "\(flow)".split(separator: ".").last ?? "no flow"
//                print("➡️ will navigate to flow = \(currentFlow) and step = \(step)")
//            })
//            .disposed(by: disposeBag)
//        
//        // didNavigate
//    }
}
