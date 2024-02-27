import UIKit

import SnapKit
import Then

import DSKit
import Domain
import MGNetworks

public class PostureDetailTextViewCollectionViewCell: UICollectionViewCell {

    static let identifier: String = PostureResourcesService.Identifier.postureDetailTextViewCollectionViewCell

    private var detailTextLabel = MGPostureInfoLabel()

    private func layout() {
        contentView.addSubviews([detailTextLabel])

        detailTextLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

public extension PostureDetailTextViewCollectionViewCell {
    func setup( index: Int, with model: PostureDetailInfoTextModel) {
        detailTextLabel.setup(index: index,
                              text: model.text
        )

        layout()
    }
}
