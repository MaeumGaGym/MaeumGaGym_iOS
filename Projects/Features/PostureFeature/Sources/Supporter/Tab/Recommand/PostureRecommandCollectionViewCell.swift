import UIKit

import SnapKit
import Then

import DSKit
import Domain
import MGNetworks

public class PostureRecommandCollectionViewCell: UICollectionViewCell {

    static let identifier: String = PostureResourcesService.Identifier.postureRecommandCollectionViewCell

    private var postureImageView = UIImageView().then {
        $0.backgroundColor = PostureResourcesService.Colors.gray50
        $0.layer.cornerRadius = 8.0
    }

    private var exerciseNameLabel = UILabel().then {
        $0.textColor = .black
        $0.backgroundColor = .clear
        $0.textAlignment = .left
    }

    private var exercisePartLabel = UILabel().then {
        $0.textColor = PostureResourcesService.Colors.gray600
        $0.backgroundColor = .clear
        $0.textAlignment = .left
    }

    private func layout() {
        addSubviews([postureImageView, exerciseNameLabel, exercisePartLabel])

        postureImageView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(148.0)
            $0.top.leading.trailing.equalToSuperview()
        }

        exerciseNameLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(20.0)
            $0.top.equalTo(postureImageView.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview()
        }

        exercisePartLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(20.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

public extension PostureRecommandCollectionViewCell {
    func setup(with exerciseData: PostureRecommandExerciseModel) {
        postureImageView.image = exerciseData.image
        exerciseNameLabel.text = exerciseData.name
        exercisePartLabel.text = exerciseData.part

        layout()
    }
}
