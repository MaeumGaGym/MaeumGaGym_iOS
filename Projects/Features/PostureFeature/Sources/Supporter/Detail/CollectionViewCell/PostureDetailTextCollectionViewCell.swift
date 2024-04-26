import UIKit

import SnapKit
import Then

import DSKit
import Domain

public class PostureDetailTextCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "PostureDetailTextCollectionViewCell"

    private var detailInfoLabel = MGPostureInfoLabel()

    private func layout() {
        contentView.addSubviews([detailInfoLabel])

        detailInfoLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

public extension PostureDetailTextCollectionViewCell {
    func setup(index: Int, with model: [PostureDetailInfoTextModel]) {
        detailInfoLabel.setup(index: index, text: model[index - 1].text)

        layout()
    }
}
