import UIKit

import SnapKit
import Then

import DSKit

public class PostureDetailPickleCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "PostureDetailPickeTableViewCell"

    private var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
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

public extension PostureDetailPickleCollectionViewCell {
    func setup(image: UIImage) {
        imageView.image = image

        attribute()
        layout()
    }
}
