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

    private lazy var rootViewController: UITabBarController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = DSKitAsset.Colors.blue500.color
        return tabBarController
    }()

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }

        switch step {
        case .tabBarIsRequired:
            return setupTabBar()
        default:
            return .none
        }
    }

    private func setupTabBar() -> FlowContributors {

        let homeService = HomeService()
        let homeRepository = HomeRepository(networkService: homeService)
        let homeFlow = HomeFlow(repository: homeRepository)

        let postureFlow = PostureFlow()
        let shopFlow = ShopFlow()
        let pickleFlow = PickleFlow()
        let selfCareFlow = SelfCareFlow()

        let flows: [Flow] = [homeFlow, postureFlow, shopFlow, pickleFlow, selfCareFlow]

        Flows.use(flows, when: .ready, block: { [weak self] root in
            guard let `self` = self else { return }
            self.rootViewController.viewControllers = root
        })
        return .multiple(flowContributors: [
            FlowContributor.contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: AppStep.homeIsRequired)),
            FlowContributor.contribute(withNextPresentable: postureFlow, withNextStepper: OneStepper(withSingleStep: AppStep.postureIsRequired)),
            FlowContributor.contribute(withNextPresentable: shopFlow, withNextStepper: OneStepper(withSingleStep: AppStep.shopIsRequired)),
            FlowContributor.contribute(withNextPresentable: pickleFlow, withNextStepper: OneStepper(withSingleStep: AppStep.pickleRequired)),
            FlowContributor.contribute(withNextPresentable: selfCareFlow, withNextStepper: OneStepper(withSingleStep: AppStep.selfCareIsRequired)),
        ])
    }

    public init() {

    }
}
