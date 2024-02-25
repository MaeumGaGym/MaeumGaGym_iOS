import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

public class MyRoutineDetailTableViewCell: BaseTableViewCell {

    static let identifier: String = "MyRoutineDetailTableViewCell"

    private var containerView = UIView()

    private var exerciseImage = UIImageView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray25.color
        $0.layer.cornerRadius = 40.0
        $0.contentMode = .scaleToFill
    }

    private let exerciseNameLabel = MGLabel(font:  UIFont.Pretendard.bodyLarge,
                                              textColor: .black,
                                              isCenter: false,
                                              numberOfLineCount: 1
    )
    
    private var exerciseRoutineLabel = MGLabel(font: UIFont.Pretendard.bodyMedium,
                                              textColor: DSKitAsset.Colors.gray400.color,
                                              isCenter: false,
                                              numberOfLineCount: 1
    )

    private var deatilImage = UIImageView().then {
        $0.image = DSKitAsset.Assets.right.image
        $0.layer.cornerRadius = 40.0
    }

    override public func layout() {
        super.layout()

        contentView.addSubviews([containerView])
        containerView.addSubviews([exerciseImage, deatilImage, exerciseNameLabel, exerciseRoutineLabel])

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        exerciseImage.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.height.equalTo(80.0)
        }

        deatilImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(28.0)
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(24.0)
        }

        exerciseNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17.0)
            $0.leading.equalTo(exerciseImage.snp.trailing).offset(18.0)
            $0.trailing.equalTo(deatilImage.snp.leading)
            $0.height.equalTo(24.0)
        }

        exerciseRoutineLabel.snp.makeConstraints {
            $0.top.equalTo(exerciseNameLabel.snp.bottom).offset(2.0)
            $0.leading.equalTo(exerciseImage.snp.trailing).offset(18.0)
            $0.trailing.equalTo(deatilImage.snp.leading)
            $0.height.equalTo(20.0)
        }
    }
}

public extension MyRoutineDetailTableViewCell {
    func setup(with model: SelfCareMyRoutineDetailExerciseModel) {
        exerciseImage.image = model.exericseImage
        exerciseNameLabel.text = model.exerciseTitle
        exerciseRoutineLabel.text = "\(model.exerciseCount)개 | \(model.exerciseSet)세트"
    }
}
