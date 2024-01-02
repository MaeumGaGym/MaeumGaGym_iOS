import Foundation
import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ viewsToAdd: UIView...) {
        viewsToAdd.forEach { addArrangedSubview($0) }
    }
}
