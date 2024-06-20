import UIKit

import RxFlow
import RxSwift
import RxCocoa

import Core
import DSKit
import Domain
import Data
import MGNetworks

import SelfCareFeature
import SelfCareFeatureInterface

public class SelfCareFlow: Flow {
    
    var viewController: SelfCareHomeViewController!
    var selfCareService: SelfCareService!
    var selfCareRepository: SelfCareRepository!
    var useCase = DefaultSelfCareUseCase(repository: SelfCareRepository(networkService: DefaultSelfCareService()))
    
    public var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController = UINavigationController(
        rootViewController: SelfCareHomeViewController(SelfCareHomeViewModel(useCase: self.useCase))
    )

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MGStep else { return .none }

        switch step {
        case .selfCoreHome:
            return setupSelfCoreScreen()
        case .popRequired:
            return popupViewController()
        
        //target
        case .targetHomeRequired:
            return navigateToTargetHome()
        case .addTargetRequired:
            return navigateToAddTarget()
        case .modifyTargetRequired(let id):
            return navigateToModifyTarget(id: id)
//        case .detailTargetRequired(let id):
//            return navigateToDetailTarget(id: id)
//        case .presentTargetAttribute:
//        
        //profile
        case .myProfileRequired:
            return navigateToMyProfile()
        case .editMyProfileRequired:
            return navigateToEditTarget()
            
        default:
            return .none
        }
    }

    private func setupSelfCoreScreen() -> FlowContributors {
        let vc = SelfCareHomeViewController(SelfCareHomeViewModel(useCase: self.useCase))
        rootViewController.view.backgroundColor = .white
        rootViewController.navigationController?.isNavigationBarHidden = true
        rootViewController.tabBarItem = UITabBarItem(
            title: "자기관리",
            image: DSKitAsset.Assets.baMuscleTapBar.image,
            selectedImage: DSKitAsset.Assets.blMuscleTapBar.image)
        rootViewController.setViewControllers([vc], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: self.rootViewController, withNextStepper: SelfCareStepper.shared))
    }
    
    private func navigateToTargetHome() -> FlowContributors {
        let vc = SelfCareTargetMainViewController(SelfCareTargetMainViewModel(useCase: self.useCase))
        rootViewController.pushViewController(vc, animated: true)
        MainTabBarContoller.shared.tabBar.isHidden = true
        return .none
    }
    
    private func navigateToAddTarget() -> FlowContributors {
        let vc = SelfCareAddTargetViewController(SelfCareAddTargetViewModel(useCase: self.useCase))
        rootViewController.pushViewController(vc, animated: true)
        return .none
    }
    
    private func navigateToModifyTarget(id: Int) -> FlowContributors {
        let vc = SelfCareEditTargetViewController(SelfCareEditTargetViewModel(useCase: self.useCase))
        vc.id = id
        rootViewController.pushViewController(vc, animated: true)
        return .none
    }
    
    private func navigateToDetailTarget(id: Int) -> FlowContributors {
        let vc = SelfCareDetailTargetViewController(SelfCareDetailTargetViewModel(useCase: self.useCase))
        vc.targetID = id
        rootViewController.pushViewController(vc, animated: true)
        return .none
    }
    
    private func navigateToEditTarget() -> FlowContributors {
        let vc = SelfCareProfileEditViewController(SelfCareProfileEditViewModel(useCase: self.useCase))
        rootViewController.pushViewController(vc, animated: true)
        return .none
    }
    
    private func navigateToMyProfile() -> FlowContributors {
        let vc = SelfCareProfileViewController(SelfCareProfileViewModel(useCase: self.useCase))
        MainTabBarContoller.shared.tabBar.isHidden = true
        rootViewController.pushViewController(vc, animated: true)
        return .none
    }
    
    private func popupViewController() -> FlowContributors {
        rootViewController.popViewController(animated: true)
        if rootViewController.viewControllers.count == 1 {
            MainTabBarContoller.shared.tabBar.isHidden = false
        }
        return .none
    }

}
