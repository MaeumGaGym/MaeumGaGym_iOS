import UIKit
import SnapKit

public extension UICollectionView {

    func setEmptyMessage(_ message: String, image: UIImage) {
        
        let containerView = StatusLayoutView(message: "아직 사진이 없네요,\n첫 사진을 올려보세요.", image: UIImage(systemName: "square.and.arrow.up.on.square")!)
        
        self.backgroundView = containerView
        
        containerView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    func restore() {
        self.backgroundView = nil
    }
}
