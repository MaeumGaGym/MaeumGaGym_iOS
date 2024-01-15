import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import DSKit
import HomeFeature

public class HomeFlow: Flow {
    public var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()

    init() {
        let viewController = TimerViewController(TimerViewModel())
        viewController.view.backgroundColor = .white
        viewController.tabBarItem = UITabBarItem(title: "홈", image: DSKitAsset.Assets.blackHome.image, selectedImage: DSKitAsset.Assets.blueHome.image)
        
        rootViewController.setViewControllers([viewController], animated: false)
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }

        switch step {
        case .otherDestination:
            rootViewController.tabBarItem.image = DSKitAsset.Assets.blackHome.image
            return .none
        default:
            return .none
        }
    }
}
