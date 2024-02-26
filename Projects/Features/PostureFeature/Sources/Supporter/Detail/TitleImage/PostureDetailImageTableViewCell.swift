import UIKit

import SnapKit
import Then

import DSKit
import Core

public class PostureDetailImageTableViewCell: BaseTableViewCell {
    static let identifier: String = "PostureDetailImageTableViewCell"

    private var postureImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.contentMode = .scaleAspectFit
    }

    public override func layout() {
        contentView.addSubviews([postureImageView])
        
        postureImageView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
}

public extension PostureDetailImageTableViewCell {
    func setup(with image: UIImage) {
        postureImageView.image = image
    }
}
