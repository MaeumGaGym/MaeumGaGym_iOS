import UIKit

public extension UINavigationController {
    func pushVC(_ viewController: UIViewController.Type, animated: Bool = true) {
        pushViewController(viewController.init(), animated: animated)
    }
}
