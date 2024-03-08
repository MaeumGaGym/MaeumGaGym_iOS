//
//  HomeFlow.swift
//  RxFlowTest
//
//  Created by 박준하 on 2/27/24.
//

import Foundation
import RxFlow
import UIKit
import ShopFeatureInterface

import Core

public class HomeFlow: Flow {
    let rootViewController = UINavigationController(rootViewController: HomeViewController()).then {
        $0.navigationBar.isHidden = true
    }

    public var root: Presentable {
        return rootViewController
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? TetstMainSteps else { return .none }

        switch step {
        case .home:
            return setupHomeScreen()
        case .infoRequired:
            return navigateToInfoViewScreen()
        case .back:
            return popupViewController()
        default:
            return .none
        }
    }

    private func setupHomeScreen() -> FlowContributors {
        rootViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        rootViewController.tabBarItem.title = "홈"
        rootViewController.tabBarItem.image = UIImage(systemName: "house")

        return .one(flowContributor: .contribute(withNextPresentable: self.root, withNextStepper: TestHomeSteppers.shared))
    }

    private func navigateToInfoViewScreen() -> FlowContributors {
        let vc = HomeDetailViewController()
        rootViewController.pushViewController(vc, animated: true)
        MainTabBarContollers.shared.tabBar.isHidden = true
        
        return .none
    }

    private func popupViewController() -> FlowContributors {
        rootViewController.popToRootViewController(animated: true)
        if rootViewController.viewControllers.count == 1 {
            MainTabBarContollers.shared.tabBar.isHidden = false
        }
        return .none
    }

    public init() {

    }
}
