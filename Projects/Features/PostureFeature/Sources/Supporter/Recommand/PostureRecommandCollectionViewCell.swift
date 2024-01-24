import UIKit

import SnapKit
import Then

import DSKit

public class PostureRecommandCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "PostureRecommandCollectionViewCell"

    private var postureImageView = UIImageView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray50.color
        $0.layer.cornerRadius = 8.0
    }

    private var exerciseNameLabel = UILabel().then {
        $0.textColor = .black
        $0.backgroundColor = .clear
        $0.textAlignment = .left
    }

    private var exercisePartLabel = UILabel().then {
        $0.textColor = DSKitAsset.Colors.gray600.color
        $0.backgroundColor = .clear
        $0.textAlignment = .left
    }

    public func setup(exerciseImage: UIImage, exerciseNameText: String, exercisePartText: String) {
        self.postureImageView.image = exerciseImage
        self.exerciseNameLabel.text = exerciseNameText
        self.exercisePartLabel.text = exercisePartText

        addViews()
        setupViews()
    }

    private func addViews() {
        [
            postureImageView,
            exerciseNameLabel,
            exercisePartLabel
        ].forEach { contentView.addSubview($0) }
    }

    private func setupViews() {

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
