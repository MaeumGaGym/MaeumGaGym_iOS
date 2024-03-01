import UIKit
import Data
import MGNetworks
import DSKit
import RxFlow
import RxSwift
import RxCocoa
import Domain

import PostureFeature
import Core

public class PostureFlow: Flow {
    
    private var rootViewController: UINavigationController!
    var postureService: PostureService!
    var postureRepository: PostureRepository!
    var useCase: DefaultPostureUseCase!
    var viewModel: PostureMainViewModel!
    var viewController: PostureMainViewController!
    
    public var root: Presentable {
        return self.rootViewController
    }
    
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MGStep else { return .none }

        switch step {
        case .posture:
            return setupPostureMainScreen()
        default:
            return .none
        }
    }
    
    private func setupService() {
        postureService = PostureService()
        postureRepository = PostureRepository(networkService: postureService)
        useCase = DefaultPostureUseCase(repository: postureRepository)
        viewModel = PostureMainViewModel()
    }

    private func setupViewController() {
        viewController = PostureMainViewController(viewModel)
        rootViewController = UINavigationController(rootViewController: viewController)
    }
    
    private func setupPostureMainScreen() -> FlowContributors {
        rootViewController.view.backgroundColor = .white
        rootViewController.tabBarItem = UITabBarItem(title: "자세", image: DSKitAsset.Assets.maeumGaGymBlackPeopleTapBar.image, selectedImage: DSKitAsset.Assets.maeumGaGymBluePeopleTapBar.image)
        rootViewController.setViewControllers([viewController], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: self.root, withNextStepper: HomeStepper.shared))
    }

    public init() {
        setupService()
        setupViewController()
    }
}
