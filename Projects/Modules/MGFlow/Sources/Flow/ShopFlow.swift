import UIKit
import RxFlow
import RxSwift
import RxCocoa
import DSKit

import ShopFeature
import Core

public class ShopFlow: Flow {
    
    private var rootViewController: UINavigationController!
    
    var viewController: ShopViewController!
    
    public var root: Presentable {
        return self.rootViewController
    }
    
    public init() {
        setupViewController()
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MGStep else { return .none }

        switch step {
        case .shopIsRequired:
            return setupPostureMainScreen()
        default:
            return .none
        }
    }

    private func setupViewController() {
        viewController = ShopViewController(Int())
        rootViewController = UINavigationController(rootViewController: viewController)
    }
    
    private func setupPostureMainScreen() -> FlowContributors {
        rootViewController.view.backgroundColor = .white
        rootViewController.tabBarItem.title = "샵"
        rootViewController.tabBarItem.image = DSKitAsset.Assets.baShopTapBar.image
        rootViewController.tabBarItem.selectedImage = DSKitAsset.Assets.blShopTapBar.image
        rootViewController.setViewControllers([viewController], animated: false)
        rootViewController.isNavigationBarHidden = true
        return .one(flowContributor: .contribute(withNextPresentable: self.root, withNextStepper: ShopStepper.shared))
    }

    private func popupViewController() -> FlowContributors {
        rootViewController.popToRootViewController(animated: true)
        if rootViewController.viewControllers.count == 1 {
            MainTabBarContoller.shared.tabBar.isHidden = false
        }
        return .none
    }
}
