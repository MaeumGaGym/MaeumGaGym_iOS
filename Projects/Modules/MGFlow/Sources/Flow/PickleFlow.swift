import UIKit
import PickleFeature
import RxFlow
import RxSwift
import RxCocoa
import DSKit

import Core

public class PickleFlow: Flow {

    private let rootViewController = UINavigationController(rootViewController: PickleViewController())

    public var root: Presentable {
        return self.rootViewController
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MGStep else { return .none }

        switch step {
        case .pickle:
            return setupPickleScreen()
        default:
            return .none
        }
    }
    
    private func setupPickleScreen() -> FlowContributors {
        rootViewController.view.backgroundColor = .white
        rootViewController.tabBarItem = UITabBarItem(title: "피클", image: DSKitAsset.Assets.bluePickleTapBar.image, selectedImage: DSKitAsset.Assets.bluePickleTapBar.image)
        
        return .one(flowContributor: .contribute(withNextPresentable: self.root, withNextStepper: HomeStepper.shared))
    }
    
    
    public init() {

    }
}
