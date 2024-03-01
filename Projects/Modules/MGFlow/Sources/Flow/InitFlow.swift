import Foundation
import Data
import UIKit

import RxFlow
import RxCocoa
import RxSwift

import Core
import DSKit

import Domain
import MGNetworks

import HomeFeatureInterface

public class InitFlow: Flow {
    public var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController =  MainTabBarContoller.shared

    private let homeFlow = HomeFlow()
    private let postureFlow = PostureFlow()
    private let shopFlow = ShopFlow()
    private let pickleFlow = PickleFlow()
    private let selfCareFlow = SelfCareFlow()

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }

        switch step {
        case .initialization:
            return setupTabBar()
        default:
            return .none
        }
    }

    private func setupTabBar() -> FlowContributors {

        let flows: [Flow] = [homeFlow, postureFlow, shopFlow, pickleFlow, selfCareFlow]

        Flows.use(flows, when: .ready, block: { [weak self] root in
            guard let `self` = self else { return }
            self.rootViewController.viewControllers = root
        })
        return .multiple(flowContributors: [
            FlowContributor.contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: AppStep.home)),
            FlowContributor.contribute(withNextPresentable: postureFlow, withNextStepper: OneStepper(withSingleStep: AppStep.postureIsRequired)),
            FlowContributor.contribute(withNextPresentable: shopFlow, withNextStepper: OneStepper(withSingleStep: AppStep.shopIsRequired)),
            FlowContributor.contribute(withNextPresentable: pickleFlow, withNextStepper: OneStepper(withSingleStep: AppStep.pickleRequired)),
            FlowContributor.contribute(withNextPresentable: selfCareFlow, withNextStepper: OneStepper(withSingleStep: AppStep.selfCareIsRequired)),
        ])
    }

    public init() {

    }
}
