import UIKit

import RxFlow
import RxSwift
import RxCocoa

import Core
import DSKit
import Domain
import Data
import MGNetworks

import HomeFeature
import HomeFeatureInterface

public class HomeFlow: Flow {

    private var rootViewController: UINavigationController!
    var homeService: HomeService!
    var homeRepository: HomeRepository!
    var useCase: DefaultHomeUseCase!
    var viewModel: HomeViewModel!
    var viewController: HomeViewController!

    public var root: Presentable {
        return rootViewController
    }

    public init() {
        setupService()
        setupViewController()
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MGStep else { return .none }

        switch step {
        case .home:
            return setupHomeScreen()
        case .homeStepRequired:
            return navigateToStepViewScreen()
        case .homeBack:
            return popupViewController()
        default:
            return .none
        }
    }

    private func setupService() {
        homeService = HomeService()
        homeRepository = HomeRepository(networkService: homeService)
        useCase = DefaultHomeUseCase(repository: homeRepository)
        viewModel = HomeViewModel(useCase: useCase)
    }

    private func setupViewController() {

        viewController = HomeViewController(viewModel)
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    private func setupHomeScreen() -> FlowContributors {
        self.rootViewController.setViewControllers(
            [viewController],
            animated: true
        )
        return .one(flowContributor: .contribute(withNextPresentable: self.root, withNextStepper: HomeStepper.shared))
    }

    private func navigateToStepViewScreen() -> FlowContributors {

        let redVC = RedViewController()
        rootViewController.pushViewController(redVC, animated: true)
        MainTabBarContoller.shared.tabBar.isHidden = true

        return .none
    }
    
    private func popupViewController() -> FlowContributors {
        rootViewController.popToRootViewController(animated: true)
        if rootViewController.viewControllers.count == 1 {
            MainTabBarContoller.shared.tabBar.isHidden = false
        }
        return .none
    }
}
