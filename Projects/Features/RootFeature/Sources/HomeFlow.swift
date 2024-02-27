import UIKit

import RxFlow
import RxSwift
import RxCocoa

import Core
import DSKit
import Domain

import HomeFeature
import HomeFeatureInterface

public class HomeFlow: Flow {

    public var repository: HomeRepositoryInterface

    public var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()

    init(repository: HomeRepositoryInterface) {
        self.repository = repository

        let useCase = DefaultHomeUseCase(repository: repository)
        let viewModel = HomeViewModel(useCase: useCase)
        let viewController = HomeViewController(viewModel)

        viewController.view.backgroundColor = DSKitAsset.Colors.gray25.color
        viewController.tabBarItem = UITabBarItem(title: "홈",
                                                 image: DSKitAsset.Assets.blackHomeTapBar.image,
                                                 selectedImage: DSKitAsset.Assets.blueHomeTapBar.image
        )

        self.rootViewController.setViewControllers([viewController], animated: false)
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }

        switch step {
        case .otherDestination:
            rootViewController.tabBarItem.image = DSKitAsset.Assets.blackHomeTapBar.image
            return .none
        default:
            return .none
        }
    }
}
