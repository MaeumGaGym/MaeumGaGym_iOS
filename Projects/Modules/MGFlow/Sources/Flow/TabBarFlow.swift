//import Foundation
//import Data
//import UIKit
//
//import RxFlow
//import RxCocoa
//import RxSwift
//
//import Core
//import DSKit
//
//import Domain
//import MGNetworks
//
//import HomeFeatureInterface
//import PickleFeatureInterface
//import ShopFeatureInterface
//import SelfCareFeatureInterface
//import PostureFeatureInterface
//
//public class TabBarFlow: Flow {
//    
//    let rootViewController = UITabBarController()
//    
//    public var root: Presentable {
//        return self.root
//    }
//    
//    public func navigate(to step: Step) -> FlowContributors {
//        guard let step = step as? MGStep else { return .none }
//
//        switch step {
//        case .TabBarIsRequired:
//            return navigateToTabBar()
//        default:
//            return .none
//        }
//    }
//    
//    private func navigateToTabBar() -> FlowContributors {
//        
//    }
//}
