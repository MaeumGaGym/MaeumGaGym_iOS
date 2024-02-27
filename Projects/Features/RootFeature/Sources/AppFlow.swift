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

public class AppFlow: Flow {

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
            return navigateToTabBarScreen()
        default:
            return .none
        }
    }

    private func navigateToTabBarScreen() -> FlowContributors {
        let homeService = HomeService()
        let homeRepository = HomeRepository(networkService: homeService)
        let homeFlow = HomeFlow(repository: homeRepository)

        let postureFlow = PostureFlow()
        let shopFlow = ShopFlow()
        let pickleFlow = PickleFlow()
        let selfCareFlow = SelfCareFlow()

        Flows.whenReady(flow1: homeFlow, flow2: postureFlow, flow3: shopFlow, flow4: pickleFlow, flow5: selfCareFlow) { [unowned self] homeRoot, postureRoot, shopRoot, pickleRoot, selfCareRoot in
            self.rootViewController.viewControllers = [homeRoot, postureRoot, shopRoot, pickleRoot, selfCareRoot]
        }

        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: AppStep.homeIsRequired)),
            .contribute(withNextPresentable: postureFlow, withNextStepper: OneStepper(withSingleStep: AppStep.postureIsRequired)),
            .contribute(withNextPresentable: shopFlow, withNextStepper: OneStepper(withSingleStep: AppStep.shopIsRequired)),
            .contribute(withNextPresentable: pickleFlow, withNextStepper: OneStepper(withSingleStep: AppStep.pickleRequired)),
            .contribute(withNextPresentable: selfCareFlow, withNextStepper: OneStepper(withSingleStep: AppStep.selfCareIsRequired))
        ])
    }

    public init() {

    }
}
