import UIKit

import SnapKit
import Then

import DSKit

public class PostureDetailImageTableViewCell: UITableViewCell {
    static let identifier: String = "PostureDetailImageTableViewCell"

    private var postureImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.contentMode = .scaleAspectFit
    }

    public func setup(image: UIImage) {
        self.postureImageView.image = image

        addView()
        setupView()
    }

    private func addView() {
        contentView.addSubview(postureImageView)
    }

    private func setupView() {
        postureImageView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
}
