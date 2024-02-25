import UIKit
import HomeFeature
import RxFlow
import Core

import Data
import Domain
import MGNetworks

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator = FlowCoordinator()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
//            window?.rootViewController = MetronomeViewController(
//                viewModel: MetronomeViewModel(metronome: Metronome.sharedInstance)
//            )
            let useCase = DefaultHomeUseCase(repository: HomeRepository(networkService: HomeService()))
            let viewModel = HomeViewModel(useCase: useCase)
            let viewController = HomeViewController(viewModel)
            window?.configure(withRootViewController: viewController)
        window?.makeKeyAndVisible()
    }
}
