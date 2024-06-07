import UIKit
import PostureFeature
import RxFlow
import Core

import Data
import Domain
import MGNetworks

import MGFlow

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator = FlowCoordinator()
    var mainFlow: PostureFlow!

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        
        let useCase = DefaultPostureUseCase(repository: PostureRepository(networkService: PostureService()))
        let viewModel = PostureDetailViewModel(useCase: useCase)
        let viewController = PostureDetailViewController(viewModel)
        
        window?.rootViewController = viewController

//        mainFlow = PostureFlow()
//
//        coordinator.coordinate(flow: mainFlow, with: OneStepper(withSingleStep: MGStep.postureDetailIsRequired(withDetailId: 0)))
//        Flows.use(mainFlow, when: .created) { root in
//            self.window?.rootViewController = root
//            self.window?.makeKey()
//        }
        window?.makeKeyAndVisible()
    }
}
