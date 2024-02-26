import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

import MGNetworks

public class PostureDetailExerciseInfoTableViewCell: BaseTableViewCell {

    static let identifier: String = PostureResourcesService.Identifier.postureDetailExerciseInfoTableViewCell

    private var exerciseWay = MGLabel(text: PostureResourcesService.Title.execiseWayTitle,
                                      font: UIFont.Pretendard.titleMedium,
                                      textColor: .black,
                                      isCenter: false
    )

    private var exerciseInfo1 = MGPostureInfoLabel(
        titleNumber: "",
        text: ""
    )
    private var exerciseInfo2 = MGPostureInfoLabel(
        titleNumber: "",
        text: ""
    )
    private var exerciseInfo3 = MGPostureInfoLabel(
        titleNumber: "",
        text: ""
    )

    public func setup(model: PostureDetailInfoModel) {
        let exerciseInfos = model.informationText
        guard exerciseInfos.count >= 3 else {
            print("운동 정보가 충분하지 않습니다.")
            return
        }
        self.exerciseInfo1.updateData(textNum: "01", text: exerciseInfos[0].text)
        self.exerciseInfo2.updateData(textNum: "02", text: exerciseInfos[1].text, numberOfLines: 2)
        self.exerciseInfo3.updateData(textNum: "03", text: exerciseInfos[2].text)

        addViews()
        setupViews()
    }

    private func addViews() {
        [
            exerciseWay,
            exerciseInfo1,
            exerciseInfo2,
            exerciseInfo3
        ].forEach { contentView.addSubview($0) }
    }

    private func setupViews() {

        exerciseWay.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(32.0)
        }

        exerciseInfo1.snp.makeConstraints {
            $0.top.equalTo(exerciseWay.snp.bottom).offset(24.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
        }

        exerciseInfo2.snp.makeConstraints {
            $0.top.equalTo(exerciseInfo1.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
        }

        exerciseInfo3.snp.makeConstraints {
            $0.top.equalTo(exerciseInfo2.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
        }
    }
}
