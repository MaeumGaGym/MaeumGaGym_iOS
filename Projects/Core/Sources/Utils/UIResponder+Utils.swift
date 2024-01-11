import Foundation
import UIKit

public extension UIResponder {
    func findViewController() -> UIViewController? {
        if let viewController = self as? UIViewController {
            return viewController
        } else {
            return self.next?.findViewController()
        }
    }
}
