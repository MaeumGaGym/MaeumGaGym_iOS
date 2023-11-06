import UIKit
import RxFlow
import RxSwift
import RxCocoa
import HomeFeature

public class HomeFlow: Flow {
    public var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()

    init() {
        let viewController = HomeViewController()
        viewController.view.backgroundColor = .white
        viewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "person"), selectedImage: nil)
        rootViewController.setViewControllers([viewController], animated: false)
    }

    public func navigate(to step: Step) -> FlowContributors {
        return .none
    }
}
