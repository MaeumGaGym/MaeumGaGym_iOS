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

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        let homeService = HomeService()
        let useCase = DefaultHomeUseCase(repository: HomeRepository(networkService: homeService))
        let viewModel = HomeViewModel(useCase: useCase)
        let viewController = HomeViewController(viewModel)
                self.window = makeWindow(scene: scene)
        window?.configure(withRootViewController: viewController)
    }
}
