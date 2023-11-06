import UIKit

import Core

public extension UILabel {
    @discardableResult
    func setTypoStyle(_ typo: UIFont) -> Self {
        self.font = typo
        return self
    }
}

public extension UITextView {
    @discardableResult
    func setTypoStyle(_ typo: UIFont) -> Self {
        self.font = typo
        return self
    }
}
