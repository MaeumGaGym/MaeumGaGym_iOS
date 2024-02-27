import UIKit
import SelfCareFeature
import RxFlow
import RxSwift
import RxCocoa
import DSKit

import Core

class SelfCareFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController(
        rootViewController: SelfCareHomeViewController(SelfCareHomeViewModel()))

    init() {
        let viewController = SelfCareHomeViewController(SelfCareHomeViewModel())
        viewController.view.backgroundColor = .white
        viewController.tabBarItem = UITabBarItem(
            title: "자기관리",
            image: DSKitAsset.Assets.blackMuscleTapBar.image,
            selectedImage: DSKitAsset.Assets.blackMuscleTapBar.image)
        rootViewController.setViewControllers([viewController], animated: false)
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }

        switch step {
        case .myProfileRequired:
            return navigateToProfileViewScreen()
        default:
            return .none
        }
    }

    private func navigateToProfileViewScreen() -> FlowContributors {
        let viewcontroller = SelfCareProfileViewController(ProfileEditViewModel())
        rootViewController.pushViewController(viewcontroller, animated: true)
//        MainTabBarContoller.shared.tabBar.isHidden = true
        return .none
    }
}
