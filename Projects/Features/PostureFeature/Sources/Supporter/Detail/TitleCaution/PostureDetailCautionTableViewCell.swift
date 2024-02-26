import UIKit

import SnapKit
import Then

import DSKit
import Domain
import MGNetworks

public class PostureDetailCautionTableViewCell: UITableViewCell {
    static let identifier: String = PostureResourcesService.Identifier.postureDetailCautionTableViewCell

    private var exerciseWay = UILabel().then {
        $0.text = PostureResourcesService.Title.cautionTitle
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.Pretendard.titleMedium
    }

    private var exerciseCaution1 = MGPostureInfoLabel(
        titleNumber: "",
        text: ""
    )

    private var exerciseCaution2 = MGPostureInfoLabel(
        titleNumber: "",
        text: ""
    )

    public func setup(model: PostureDetailInfoModel) {
        let exerciseInfos = model.informationText
        guard exerciseInfos.count >= 2 else {
            print("운동 정보가 충분하지 않습니다.")
            return
        }
        self.exerciseCaution1.updateData(textNum: "01", text: exerciseInfos[0].text)
        self.exerciseCaution2.updateData(textNum: "01", text: exerciseInfos[1].text, numberOfLines: 2)

        addViews()
        setupViews()
    }

    private func addViews() {
        [
            exerciseWay,
            exerciseCaution1,
            exerciseCaution2
        ].forEach { contentView.addSubview($0) }
    }

    private func setupViews() {

        exerciseWay.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(32.0)
        }

        exerciseCaution1.snp.makeConstraints {
            $0.top.equalTo(exerciseWay.snp.bottom).offset(24.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
        }

        exerciseCaution2.snp.makeConstraints {
            $0.top.equalTo(exerciseCaution1.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
        }
    }
}
