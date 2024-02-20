import UIKit

import SnapKit
import Then

import DSKit

public class PostureDetailPickleCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "PostureDetailPickleCollectionViewCell"

    private var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    public func setup(image: UIImage) {
        imageView.image = image

        attribute()
        layout()
    }

    private func attribute() {
        self.layer.cornerRadius = 8.0
    }

    private func layout() {
        contentView.addSubviews([imageView])

        imageView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
}
