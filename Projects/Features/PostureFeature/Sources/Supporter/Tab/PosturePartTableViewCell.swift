import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

public class PosturePartTableViewCell: BaseTableViewCell {

    static let identifier: String = "PostureChestTableViewCell"

    private let postureImageView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 8.0
    }

    private let exerciseNameLabel = MGLabel(font: UIFont.Pretendard.bodyMedium,
                                            textColor: .black,
                                            isCenter: false
    )

    public override func layout() {
        super.layout()
        
        contentView.addSubviews([postureImageView, exerciseNameLabel])

        postureImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalToSuperview().offset(12.0)
            $0.width.height.equalTo(64.0)
        }

        exerciseNameLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(34.0)
            $0.leading.equalTo(postureImageView.snp.trailing).offset(18.0)
            $0.height.equalTo(20.0)
        }
    }
}

public extension PosturePartTableViewCell {
    func setup(with exerciseData: PosturePartExerciseModel) {
        postureImageView.image = exerciseData.image
        exerciseNameLabel.text = exerciseData.name
    }
}
