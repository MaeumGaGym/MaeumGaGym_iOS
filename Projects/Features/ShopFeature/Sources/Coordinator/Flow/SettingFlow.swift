//
//  SettingFlow.swift
//  RxFlowTest
//
//  Created by 박준하 on 2/27/24.
//

import Foundation
import UIKit
import RxFlow

import Core
import ShopFeatureInterface

public class SettingFlow: Flow {
    lazy var rootViewController = UINavigationController().then { $0.isNavigationBarHidden = true }

    public var root: Presentable {
        return self.rootViewController
    }

    public var viewModel = SettingViewModel()

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? TetstMainSteps else { return .none }

        switch step {
        case .setting:
            return setSettingScreen()
        case .firstRequired:
            return navigateToFirstScreen()
        case .thirdRequired:
            return navigateToThirdScreen()
        case .modalRequired:
            return navigateToModalScreen()
        case .back:
            return popViewController()
        case .dismiss:
            return dismiss()
        default:
            return .none
        }
    }

    private func setSettingScreen() -> FlowContributors {
        rootViewController.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        rootViewController.tabBarItem.title = "설정"
        rootViewController.tabBarItem.image = UIImage(systemName: "gearshape")

        return FlowSugar(viewModel, SettingViewController.self)
            .oneStepPushBy(self.rootViewController)
    }

    private func navigateToFirstScreen() -> FlowContributors {
        MainTabBarContollers.shared.tabBar.isHidden = false

        return FlowSugar(viewModel, FirstViewController.self)
            .oneStepPushBy(self.rootViewController)
    }

    private func navigateToThirdScreen() -> FlowContributors {
        MainTabBarContollers.shared.tabBar.isHidden = true
        return FlowSugar(viewModel, ThirdViewController.self)
            .oneStepPushBy(self.rootViewController)
    }

    private func popViewController() -> FlowContributors {
        rootViewController.popViewController(animated: true)
        if rootViewController.viewControllers.count == 1 {
            MainTabBarContollers.shared.tabBar.isHidden = false
        }
        return .none
    }

    private func navigateToModalScreen() -> FlowContributors {
        return FlowSugar(viewModel, ModalViewController.self)
            .oneStepPopoverPresent(self.rootViewController)
    }

    private func dismiss() -> FlowContributors {
        self.rootViewController.dismiss(animated: true)
        return .none
    }
    
    public init() {
        
    }
}
