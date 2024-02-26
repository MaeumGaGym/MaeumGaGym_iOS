import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

import MGNetworks

public class PosturePartTableViewCell: BaseTableViewCell {

    static let identifier: String = PostureResourcesService.Identifier.posturePartTableViewCell

    private let postureImageView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 8.0
    }

    private let exerciseNameLabel = UILabel().then {
        $0.textColor = .black
        $0.backgroundColor = .clear
        $0.textAlignment = .left
        $0.font = UIFont.Pretendard.bodyMedium
    }

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
