import UIKit
import RxFlow
import RxSwift
import RxCocoa
import DSKit

public class ShopFlow: Flow {
    public var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()

    public init() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        viewController.tabBarItem = UITabBarItem(title: "샵", image: DSKitAsset.Assets.baShopTapBar.image, selectedImage: DSKitAsset.Assets.blShopTapBar.image)
        rootViewController.setViewControllers([viewController], animated: false)
    }

    public func navigate(to step: Step) -> FlowContributors {
        return .none
    }
}
