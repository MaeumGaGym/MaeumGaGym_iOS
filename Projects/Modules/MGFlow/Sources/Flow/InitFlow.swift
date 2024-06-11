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
        guard let step = step as? MGStep else { return .none }

        switch step {
        case .initialization:
            return setupTabBar()
        default:
            return .none
        }
    }

    private func setupTabBar() -> FlowContributors {
        Flows.use(homeFlow,
                  postureFlow,
                  shopFlow,
                  pickleFlow,
                  selfCareFlow,
                  when: .created
        ) { home, posture, shop, pickle, selfCare in
            home.tabBarItem = MGTabBarTypeItem(.home)
            posture.tabBarItem = MGTabBarTypeItem(.posture)
            shop.tabBarItem = MGTabBarTypeItem(.shop)
            pickle.tabBarItem = MGTabBarTypeItem(.pickle)
            selfCare.tabBarItem = MGTabBarTypeItem(.selfCare)
            
            self.rootViewController.setViewControllers([home, posture, shop, pickle, selfCare], animated: true)
        }
        return .multiple(flowContributors: [
            FlowContributor.contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: MGStep.home)),
            FlowContributor.contribute(withNextPresentable: postureFlow, withNextStepper: OneStepper(withSingleStep: MGStep.postureIsRequired)),
            FlowContributor.contribute(withNextPresentable: shopFlow, withNextStepper: OneStepper(withSingleStep: MGStep.shopIsRequired)),
            FlowContributor.contribute(withNextPresentable: pickleFlow, withNextStepper: OneStepper(withSingleStep: MGStep.pickleRequired)),
            FlowContributor.contribute(withNextPresentable: selfCareFlow, withNextStepper: OneStepper(withSingleStep: MGStep.selfCoreHome)),
        ])
    }

    public init() {

    }
}
