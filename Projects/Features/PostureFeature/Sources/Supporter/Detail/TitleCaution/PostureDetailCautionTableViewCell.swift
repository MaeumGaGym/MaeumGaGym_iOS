import UIKit
import SnapKit
import Then
import DSKit

public class PostureDetailCautionTableViewCell: UITableViewCell {
    static let identifier: String = "PostureDetailCautionTableViewCell"
    
    private var exerciseWay = UILabel().then {
        $0.text = "주의사항"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.Pretendard.titleMedium
    }
    
    private var exerciseCaution1 = MaeumGaGymPostureInfoLabel(titleNumber: "01", text: "양팔을 가슴 옆에 두고 바닥에 엎드립니다.")
    
    private var exerciseCaution2 = MaeumGaGymPostureInfoLabel(titleNumber: "02", text: "양팔을 가슴 옆에 두고 바닥에 엎드립니다.", numberOfLines: 2)
    
    public func setup(model: postureExerciseCautionModel) {
        let exerciseInfos = model.data
        guard exerciseInfos.count >= 2 else {
            print("운동 정보가 충분하지 않습니다.")
            return
        }

        self.exerciseCaution1.updateData(textNum: exerciseInfos[0].num, text: exerciseInfos[0].way)
        self.exerciseCaution2.updateData(textNum: exerciseInfos[1].num, text: exerciseInfos[1].way, numberOfLines: 2)

        
        addViews()
        setupViews()
    }
    
    private func addViews() {
        [
            exerciseWay,
            exerciseCaution1,
            exerciseCaution2,
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