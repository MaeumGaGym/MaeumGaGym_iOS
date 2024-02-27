import UIKit
import RxFlow
import RxSwift
import RxCocoa
import DSKit

class ShopFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()

    init() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        viewController.tabBarItem = UITabBarItem(title: "샵", image: DSKitAsset.Assets.blackShopTapBar.image, selectedImage: DSKitAsset.Assets.blueShopTapBar.image)
        rootViewController.setViewControllers([viewController], animated: false)
    }

    func navigate(to step: Step) -> FlowContributors {
        return .none
    }
}
