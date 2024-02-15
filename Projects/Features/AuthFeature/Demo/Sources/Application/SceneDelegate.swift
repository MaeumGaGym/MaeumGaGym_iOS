import UIKit
import AuthFeatureInterface
import RxFlow
import Core
import AuthFeature

import Domain
import Data

import MGNetworks

import KakaoSDKAuth
import KakaoSDKCommon

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        KakaoSDK.initSDK(appKey: "44df4ecfe4e1218c17550a6ab201d87d")

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let useCase = DefaultAuthUseCase(authRepository: IntroRepository(networkService: IntroService()))
        let viewModel = IntroViewModel(authUseCase: useCase)
        let viewController = IntroViewController(viewModel)
        window?.configure(withRootViewController: viewController)
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
