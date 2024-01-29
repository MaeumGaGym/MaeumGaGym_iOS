import UIKit

public extension UIWindow {
    func configure(withRootViewController rootViewController: UIViewController) {
        self.rootViewController = UINavigationController(rootViewController: rootViewController)
        makeKeyAndVisible()
    }
}
