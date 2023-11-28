import UIKit
import PickleFeature
import RxFlow
import RxSwift
import RxCocoa
import DSKit

class PickleFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()

    init() {
        let viewController = PickleViewController()
        viewController.view.backgroundColor = .white
        viewController.tabBarItem = UITabBarItem(title: nil, image: DSKitAsset.Assets.whitePickle.image, selectedImage: nil)
        rootViewController.setViewControllers([viewController], animated: false)
        viewController.view.tintColor = .white
    }

    func navigate(to step: Step) -> FlowContributors {
        return .none
    }
}
