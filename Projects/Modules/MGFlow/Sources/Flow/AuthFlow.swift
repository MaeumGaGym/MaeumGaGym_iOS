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
    var authService: AuthService!
    var authRepository: AuthRepository!
    var useCase: DefaultAuthUseCase!
    var viewModel: IntroViewModel!
    var viewController: IntroViewController!

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
        case .initialization:
            return navigateToMain()
        case .authBack:
            return popupViewController()
        default:
            return .none
        }
    }

    private func setupService() {
        authService = AuthService()
        authRepository = AuthRepository(networkService: authService)
        useCase = DefaultAuthUseCase(authRepository: authRepository)
        viewModel = IntroViewModel(authUseCase: useCase)
    }

    private func setupViewController() {
        viewController = IntroViewController(viewModel)
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    private func setupAuthMainScreen() -> FlowContributors {
        rootViewController.view.backgroundColor = .white
        rootViewController.setViewControllers([viewController], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: self.root, withNextStepper: AuthStepper.shared))
    }

    private func navigateToAgreeViewScreen() -> FlowContributors {
        let vc = AgreeViewController(AgreeViewModel(useCase: self.useCase))
        rootViewController.pushViewController(vc, animated: true)
        return .none
    }

    private func navigateToNicknameViewScreen() -> FlowContributors {
        let vc = NicknameViewController(NicknameViewModel(useCase: self.useCase))
        rootViewController.pushViewController(vc, animated: true)
        return .none
    }

    private func navigateToCompleteViewScreen() -> FlowContributors {
        let vc = CompleteSignUpViewController(CompleteViewModel())
        rootViewController.pushViewController(vc, animated: true)
        vc.navigationItem.hidesBackButton = true
        MainTabBarContoller.shared.tabBar.isHidden = true
        return .none
    }
    
    private func navigateToMain() -> FlowContributors {
        let profileFlow = InitFlow()
        Flows.use(profileFlow, when: .created) { [weak self] root in
            self?.rootViewController.setViewControllers([root], animated: true)
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: profileFlow,
            withNextStepper: OneStepper(withSingleStep: MGStep.initialization)
        ))
    }

    private func popupViewController() -> FlowContributors {
        rootViewController.popViewController(animated: true)
        return .none
    }
}
