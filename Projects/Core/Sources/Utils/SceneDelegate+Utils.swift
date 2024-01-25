import UIKit

public extension UIResponder {
    func makeWindow(scene: UIScene) -> UIWindow? {
        guard let windowScene = (scene as? UIWindowScene) else { return nil }
        return UIWindow(windowScene: windowScene)
    }
}

