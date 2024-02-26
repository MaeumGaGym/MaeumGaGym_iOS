import UIKit

import SnapKit
import Then

import DSKit
import Domain
import MGNetworks

public class PostureDetailTextViewCollectionViewCell: UICollectionViewCell {

    static let identifier: String = PostureResourcesService.Identifier.postureDetailTextViewCollectionViewCell

    private var detailTextLabel = MGPostureInfoLabel(
        titleNumber: "",
        text: ""
    )
    private func layout() {
        contentView.addSubviews([detailTextLabel])

        detailTextLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

public extension PostureDetailTextViewCollectionViewCell {
    func setup(with model: PostureDetailModel, index: Int) {
        detailTextLabel.updateData(textNum: "0\(index)",
                                   text: model.exerciseWayData[index].text
        )

        layout()
    }
}
