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
    var authService: DefaultAuthService!
    var authRepository: AuthRepository!
    var useCase: DefaultAuthUseCase!
    var viewModel: SplashViewModel!
    var viewController: SplashViewController!

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
        case .authSplashIsRequired:
            return setupAuthMainScreen()
        case .authIntroIsRequired:
            return navigateToIntroViewScreen()
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
        authService = DefaultAuthService()
        authRepository = AuthRepository(networkService: authService)
        useCase = DefaultAuthUseCase(authRepository: authRepository)
        viewModel = SplashViewModel(authUseCase: useCase)
    }

    private func setupViewController() {
        viewController = SplashViewController(viewModel)
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    private func setupAuthMainScreen() -> FlowContributors {
        rootViewController.view.backgroundColor = .white
        rootViewController.setViewControllers([viewController], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: self.root, withNextStepper: AuthStepper.shared))
    }
    
    private func navigateToIntroViewScreen() -> FlowContributors {
        let vc = IntroViewController(IntroViewModel(authUseCase: self.useCase))
        rootViewController.pushViewController(vc, animated: false)
        vc.navigationItem.hidesBackButton = true
        return .none
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
        let vc = CompleteSignUpViewController(CompleteViewModel(authUseCase: self.useCase))
        rootViewController.pushViewController(vc, animated: true)
        vc.navigationItem.hidesBackButton = true
        MainTabBarContoller.shared.tabBar.isHidden = true
        return .none
    }
    
    private func navigateToMain() -> FlowContributors {
        let profileFlow = InitFlow()
        Flows.use(profileFlow, when: .created) { [weak self] root in
            self?.rootViewController.setViewControllers([root], animated: false)
        }
        
        MainTabBarContoller.shared.tabBar.isHidden = false

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
