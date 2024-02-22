import UIKit

import RxFlow

import Domain
import Data
import MGNetworks

import SelfCareFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
//        let useCase = DefaultSelfCareUseCase(repository: SelfCareRepository(networkService: SelfCareService()))
//        let viewModel = SelfCareMyRoutineDetailViewModel(useCase: useCase)
//        let viewController = SelfCareMyRoutineDetailViewController(viewModel)
//        window?.configure(withRootViewController: viewController)
        window?.configure(withRootViewController: SelfCareHomeViewController(SelfCareHomeViewModel()))
        window?.makeKeyAndVisible()
    }
}
