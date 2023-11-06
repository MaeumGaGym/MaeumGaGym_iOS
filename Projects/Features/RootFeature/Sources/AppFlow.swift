import Foundation
import RxFlow
import RxCocoa
import RxSwift
import Core
import UIKit

public class AppFlow: Flow {
    
    public var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UITabBarController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor.black
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
        let homeFlow = HomeFlow()
        let postureFlow = PostureFlow()
        let selfCareFlow = SelfCareFlow()
        let shopFlow = ShopFlow()

        Flows.whenReady(flow1: homeFlow, flow2: postureFlow, flow3: selfCareFlow, flow4: shopFlow) { [unowned self] homeRoot, postureRoot, selfCareRoot, shopRoot in
            self.rootViewController.viewControllers = [homeRoot, postureRoot, selfCareRoot, shopRoot]
        }

        return .multiple(flowContributors: [.contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: AppStep.homeIsRequired)),
                                            .contribute(withNextPresentable: postureFlow, withNextStepper: OneStepper(withSingleStep: AppStep.postureIsRequired)),
                                            .contribute(withNextPresentable: selfCareFlow, withNextStepper: OneStepper(withSingleStep: AppStep.selfCareIsRequired)),
                                             .contribute(withNextPresentable: shopFlow, withNextStepper: OneStepper(withSingleStep: AppStep.shopIsRequired))])
    }
    
    public init() {
        
    }
}
