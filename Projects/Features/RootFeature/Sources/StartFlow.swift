import UIKit
import AuthFeature
import RxFlow
import RxSwift
import RxCocoa

class StartFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()

    init() {
        let viewController = StartViewController(StartViewModel())
        viewController.view.backgroundColor = .white
        rootViewController.setViewControllers([viewController], animated: false)
    }

    func navigate(to step: Step) -> FlowContributors {
        return .none
    }
}
