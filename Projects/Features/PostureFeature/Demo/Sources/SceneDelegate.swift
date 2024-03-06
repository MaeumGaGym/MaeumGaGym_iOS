import UIKit

import RxFlow

import Core
import Domain
import Data

import MGNetworks
import PostureFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator = FlowCoordinator()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: windowScene)
            let useCase = DefaultPostureUseCase(repository: PostureRepository(networkService: PostureService()))
            let viewModel = PostureMainViewModel(useCase: useCase)
            let viewController = PostureMainViewController(viewModel)
            window?.rootViewController = UINavigationController(
                rootViewController: viewController)
            window?.makeKeyAndVisible()
        }
}
