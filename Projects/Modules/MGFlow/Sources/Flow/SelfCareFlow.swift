import UIKit

import SelfCareFeature

import RxFlow
import RxSwift
import RxCocoa

import DSKit

import Core

public class SelfCareFlow: Flow {
    
    var viewController: SelfCareHomeViewController!
    
    public var root: Presentable {
        return self.rootViewController
    }

    private var rootViewController = UINavigationController(
        rootViewController: SelfCareHomeViewController(SelfCareHomeViewModel()))

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MGStep else { return .none }

        switch step {
        case .selfCoreHome:
            return setupSelfCoreScreen()
        default:
            return .none
        }
    }
    
    private func setupViewController() {
        viewController = SelfCareHomeViewController(SelfCareHomeViewModel())
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    private func setupSelfCoreScreen() -> FlowContributors {
        rootViewController.view.backgroundColor = .white
        rootViewController.tabBarItem = UITabBarItem(
            title: "자기관리",
            image: DSKitAsset.Assets.baMuscleTapBar.image,
            selectedImage: DSKitAsset.Assets.blMuscleTapBar.image)
        rootViewController.setViewControllers([viewController], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: self.root, withNextStepper: HomeStepper.shared))
    }

    public init() {
        setupViewController()
    }
}
