//
//  HomeFlow.swift
//  RootFeatureTests
//
//  Created by 박준하 on 11/6/23.
//  Copyright © 2023 MaeumGaGym-iOS. All rights reserved.
//

import Foundation
import RxFlow
import UIKit
import Core
import HomeFeature

class HomeFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init() {}

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        switch step {
        case .homeIsRequired:
            return self.navigateToHome()
        case .loginIsRequired:
            return .end(forwardToParentFlowWithStep: AppStep.loginIsRequired)
        }
    }
    
    private func navigateToHome() -> FlowContributors {
        let viewController = HomeViewController()
        self.rootViewController.setViewControllers([viewController], animated: false)
        return .one(flowContributor: .contribute(withNext: viewController))
    }
}
