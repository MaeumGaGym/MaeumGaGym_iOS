//import UIKit
//
//public protocol ViewControllable {
//    var viewController: UIViewController { get }
//    var asNavigationController: UINavigationController { get }
//}
//public extension ViewControllable where Self: UIViewController {
//    var viewController: UIViewController {
//        return self
//    }
//    
//    var asNavigationController: UINavigationController {
//        return self as? UINavigationController
//        ?? UINavigationController(rootViewController: self)
//    }
//}
//
//extension UIViewController: ViewControllable {}
