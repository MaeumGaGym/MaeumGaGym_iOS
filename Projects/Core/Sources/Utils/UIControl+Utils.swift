import UIKit

public extension UIControl {
    typealias UIControlTargetClosure = (UIControl) -> Void

    @objc func closureAction(_ sender: UIControl) {
        targetClosure?(sender)
    }

    func addAction(for event: UIControl.Event, closure: @escaping UIControlTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(closureAction(_:)), for: event)
    }
}

private extension UIControl {
    struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }

    var targetClosure: UIControlTargetClosure? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIControlTargetClosure
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
