import UIKit

import SnapKit
import Then

import Core
import DSKit
import Domain

import MGNetworks

public class MyRoutineEditTableViewCell: BaseTableViewCell {
    static let identifier: String = "MyRoutineEditTableViewCell"

    private var containerView = UIView()

    private var exerciseImage = UIImageView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray25.color
        $0.layer.cornerRadius = 40.0
        $0.contentMode = .center
    }

    private var exerciseNameLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
    }

    private var deleteButton = MGImageButton(image: DSKitAsset.Assets.blackCancel.image)

    private let numberCountView = MyRoutineCountView()
    private let setCountView = MyRoutineCountView()

    public override func layout() {
        addSubviews([containerView])
        containerView.addSubviews([exerciseImage, exerciseNameLabel, deleteButton, numberCountView, setCountView])

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(40.0)
        }

        exerciseImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(80.0)
        }

        exerciseNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28.0)
            $0.leading.equalTo(exerciseImage.snp.trailing).offset(18.0)
            $0.trailing.equalTo(deleteButton.snp.leading)
            $0.height.equalTo(24.0)
        }

        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28.0)
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(24.0)
        }

        numberCountView.snp.makeConstraints {
            $0.top.equalTo(exerciseImage.snp.bottom).offset(12.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(36.0)
        }

        setCountView.snp.makeConstraints {
            $0.top.equalTo(numberCountView.snp.bottom).offset(12.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(36.0)
        }
    }
}

public extension MyRoutineEditTableViewCell {
    func setup(with model: MyRoutineEditExerciseModel) {
        exerciseImage.image = model.exerciseImage
        exerciseNameLabel.text = model.exerciseName

        changeCountView(with: model)
    }
}

private extension MyRoutineEditTableViewCell {
    func changeCountView(with model: MyRoutineEditExerciseModel) {
        numberCountView.setup(text: model.textFieldData[0].textFieldTitle)
        setCountView.setup(text: model.textFieldData[1].textFieldTitle)

        numberCountView.textFieldData(number: model.textFieldData[0].exerciseCount)
        setCountView.textFieldData(number: model.textFieldData[1].exerciseCount)
    }
}
