//
//  LoginFlow.swift
//  RootFeatureTests
//
//  Created by 박준하 on 11/6/23.
//  Copyright © 2023 MaeumGaGym-iOS. All rights reserved.
//

import Foundation
import RxFlow
import UIKit
import AuthFeature
import Core

public class LoginFlow: Flow {
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()
    
    public var root: Presentable {
        return self.rootViewController
    }
    
    init() {}
    
    public func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? AppStep else { return .none }
        switch step {
        case .loginIsRequired:
            return self.navigateToLogin()
        case .homeIsRequired:
            return .end(forwardToParentFlowWithStep: AppStep.homeIsRequired)
        }
    }
    
    private func navigateToLogin() -> FlowContributors {
        let vm = LoginViewModel()
        let vc = LoginViewController(vm)
        
        self.rootViewController.setViewControllers([vc], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }

}
