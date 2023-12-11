import UIKit
import DSKit
import RxFlow
import RxSwift
import RxCocoa

class PostureFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()

    init() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        viewController.tabBarItem = UITabBarItem(title: "자세", image: DSKitAsset.Assets.maeumGaGymBlackPeople.image, selectedImage: DSKitAsset.Assets.maeumGaGymBluePeople.image)
        rootViewController.setViewControllers([viewController], animated: false)
    }

    func navigate(to step: Step) -> FlowContributors {
        return .none
    }
}
