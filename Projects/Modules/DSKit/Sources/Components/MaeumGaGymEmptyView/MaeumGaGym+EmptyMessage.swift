import UIKit
import SnapKit

public extension UICollectionView {

    func setEmptyMessage(_ message: String, image: UIImage) {
        
        let containerView = StatusLayoutView(message: message, image: image)
        
        self.backgroundView = containerView
        
        containerView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    func restore() {
        self.backgroundView = nil
    }
}
