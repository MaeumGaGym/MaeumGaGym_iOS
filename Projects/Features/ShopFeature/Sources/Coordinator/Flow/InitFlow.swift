//
//  InitFlow.swift
//  RxFlowTest
//
//  Created by 박준하 on 2/27/24.
//

import Foundation
import RxFlow
import UIKit
import ShopFeatureInterface

import Core

public class InitFlow: Flow {
    public var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController = MainTabBarContollers.shared

    private let homeFlow = HomeFlow()
    private let settingFlow = SettingFlow()

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? TetstMainSteps else { return .none }

        switch step {
        case .initialization:
            return setupTabBar()
        default:
            return .none
        }
    }

    private func setupTabBar() -> FlowContributors {

        let flows: [Flow] = [homeFlow, settingFlow]

        Flows.use(flows, when: .ready, block: { [weak self] root in
            guard let `self` = self else { return }
            self.rootViewController.viewControllers = root
        })
        return .multiple(flowContributors:
                            [FlowContributor.contribute(withNextPresentable: homeFlow,
                                                        withNextStepper: OneStepper(withSingleStep: TetstMainSteps.home)),
                             FlowContributor.contribute(withNextPresentable: settingFlow,
                                                        withNextStepper: OneStepper(withSingleStep: TetstMainSteps.setting))])
    }

    public init() {

    }
}
