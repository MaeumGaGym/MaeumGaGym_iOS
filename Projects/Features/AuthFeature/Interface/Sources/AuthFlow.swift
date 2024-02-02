// import Foundation
// import RxFlow
// import RxCocoa
// import RxSwift
// import Core
// import UIKit
// import RootFeature
//
// public class AuthFlow: Flow {
//
//    public var root: Presentable {
//        return self.rootViewController
//    }
//
//    private lazy var rootViewController: UITabBarController = {
//        let tabBarController = UITabBarController()
//        tabBarController.tabBar.tintColor = UIColor.black
//        return tabBarController
//    }()
//
//    public func navigate(to step: Step) -> FlowContributors {
//        guard let step = step as? AppStep else { return .none }
//
//        switch step {
//        case .startRequired:
//            return navigateToStartScreen()
//        default:
//            return .none
//        }
//    }
//
//    private func navigateToStartScreen() -> FlowContributors {
//        let startFlow = StartFlow()
//        Flows.whenReady(flow1: startFlow) { [unowned self] startRoot in
//            self.rootViewController.present(startRoot, animated: true)
//        }
//        return .one(flowContributor: .contribute(
//            withNextPresentable: startFlow,
//            withNextStepper: OneStepper(withSingleStep: AppStep.startRequired)))
//    }
//
//    public init() {
//        
//    }
// }
