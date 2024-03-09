import UIKit

import RxFlow
import RxSwift
import RxCocoa

import Data
import MGNetworks
import Domain

import DSKit
import AuthFeature
import Core

public class AuthFlow: Flow {

    private var rootViewController: UINavigationController!
    var postureService: IntroService!
    var postureRepository: IntroRepository!
    var useCase: DefaultAuthUseCase!
    var viewModel: AgreeViewModel!
    var viewController: AgreeViewController!

    public var root: Presentable {
        return self.rootViewController
    }

    public init() {
        setupService()
        setupViewController()
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MGStep else { return .none }

        switch step {
        case .authIntroIsRequired:
            return setupAuthMainScreen()
        case .authAgreeIsRequired:
            return navigateToAgreeViewScreen()
        case .authNickNameIsRequired:
            return navigateToNicknameViewScreen()
        case .authCompleteIsRequired:
            return navigateToCompleteViewScreen()
        case .authBack:
            return popupViewController()
        default:
            return .none
        }
    }

    private func setupService() {
        postureService = IntroService()
        postureRepository = IntroRepository(networkService: postureService)
        useCase = DefaultAuthUseCase(introRepository: postureRepository)
        viewModel = AgreeViewModel(useCase: useCase)
    }

    private func setupViewController() {
        viewController = AgreeViewController(viewModel)
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    private func setupAuthMainScreen() -> FlowContributors {
        rootViewController.view.backgroundColor = .white
        rootViewController.setViewControllers([viewController], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: self.root, withNextStepper: AuthStepper.shared))
    }

    private func navigateToIntroViewScreen() -> FlowContributors {
        let vc = IntroViewController(IntroViewModel(authUseCase: self.useCase))
        rootViewController.present(vc, animated: true)
        MainTabBarContoller.shared.tabBar.isHidden = true
        return .none
    }

    private func navigateToAgreeViewScreen() -> FlowContributors {
        let vc = AgreeViewController(AgreeViewModel(useCase: self.useCase))
        rootViewController.pushViewController(vc, animated: true)
        MainTabBarContoller.shared.tabBar.isHidden = true
        return .none
    }

    private func navigateToNicknameViewScreen() -> FlowContributors {
        let vc = NicknameViewController(NicknameViewModel(useCase: self.useCase))
        rootViewController.pushViewController(vc, animated: true)
        MainTabBarContoller.shared.tabBar.isHidden = true
        return .none
    }

    private func navigateToCompleteViewScreen() -> FlowContributors {
        let vc = CompleteSignUpViewController(CompleteViewModel())
        rootViewController.pushViewController(vc, animated: true)
        MainTabBarContoller.shared.tabBar.isHidden = true
        return .none
    }

    private func popupViewController() -> FlowContributors {
        rootViewController.popToRootViewController(animated: true)
        if rootViewController.viewControllers.count == 1 {
            MainTabBarContoller.shared.tabBar.isHidden = true
        }
        return .none
    }
}
