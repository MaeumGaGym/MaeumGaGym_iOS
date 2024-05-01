import UIKit

import SnapKit
import Then

import DSKit
import Domain

public class PostureRecommandCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "PostureRecommandCollectionViewCell"

    private var postureImageView = UIImageView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray50.color
        $0.layer.cornerRadius = 8.0
    }

    private var exerciseNameLabel = MGLabel(font: UIFont.Pretendard.labelMedium, 
                                            textColor: .black,
                                            isCenter: false
    )

    private var exercisePartLabel = MGLabel(font: UIFont.Pretendard.bodyMedium,
                                            textColor: DSKitAsset.Colors.gray600.color,
                                            isCenter: false
    )

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
        exerciseNameLabel.changeText(text: exerciseData.name)
        exercisePartLabel.changeText(text: exerciseData.part)

        layout()
    }
}
