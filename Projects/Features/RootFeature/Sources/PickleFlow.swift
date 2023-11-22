import UIKit
import PickleFeature
import RxFlow
import RxSwift
import RxCocoa

class PickleFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()

    init() {
        let viewController = PickleViewController()
        viewController.view.backgroundColor = .white
        viewController.tabBarItem = UITabBarItem(title: "Pickle", image: UIImage(systemName: "ipodtouch"), selectedImage: nil)
        rootViewController.setViewControllers([viewController], animated: false)
    }

    func navigate(to step: Step) -> FlowContributors {
        return .none
    }
}
