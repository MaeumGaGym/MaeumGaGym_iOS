import UIKit

import SnapKit
import Then

import DSKit
import Domain

public class PostureDetailTagCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "PostureDetailTagCollectionViewCell"

    private var tagLabel = MGTagLabel(text: "")

    private func layout() {
        contentView.addSubviews([tagLabel])

        tagLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

public extension PostureDetailTagCollectionViewCell {
    func setup(with model: PostureDetailExerciseKindModel) {
        tagLabel.updateData(text: model.exerciseTag)

        layout()
    }
}
