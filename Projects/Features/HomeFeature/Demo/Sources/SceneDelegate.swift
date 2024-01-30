import UIKit
import HomeFeatureInterface
import RxFlow
import Core

import Data
import Domain

import HomeFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        let useCase = DefaultHomeUseCase(repository: HomeRepository())
        let viewModel = HomeViewModel(useCase: useCase)
        let viewController = HomeViewController(viewModel)
                self.window = makeWindow(scene: scene)
        window?.configure(withRootViewController: viewController)
    }
}
