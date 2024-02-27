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
        viewController.tabBarItem = UITabBarItem(title: "피클", image: DSKitAsset.Assets.bluePickleTapBar.image, selectedImage: DSKitAsset.Assets.bluePickleTapBar.image)
        rootViewController.setViewControllers([viewController], animated: false)
    }

    func navigate(to step: Step) -> FlowContributors {
        return .none
    }
}
