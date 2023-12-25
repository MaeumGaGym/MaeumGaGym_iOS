import UIKit

public final class NavigationBar: UINavigationBar {
    
    var navigationController : UINavigationController? = nil
    var type : MaeumGaGymBottomSheetType = .plain
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        switch type {
        case .plain:
            return view
        case .navigation(title: _):
            if view is UIControl {
                return view
            }
            return navigationController?.topViewController?.view
        }
    }
}
