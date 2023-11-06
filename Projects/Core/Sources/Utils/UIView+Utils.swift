import UIKit
import RxCocoa
import RxSwift

public extension UIView {
    func addSubviews(_ viewsToAdd: [UIView]) {
        viewsToAdd.forEach({addSubview($0)})
    }
}
