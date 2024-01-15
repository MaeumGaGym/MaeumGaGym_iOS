import UIKit
import SnapKit
import Then
import DSKit

public class PostureDetailExerciseInfoTableViewCell: UITableViewCell {
    
    static let identifier: String = "PostureDetailExerciseInfoTableViewCell"
    
    private var exerciseWay = UILabel().then {
        $0.text = "운동 방법"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.Pretendard.titleMedium
    }
    
    private var exerciseInfo1 = MaeumGaGymPostureInfoLabel(titleNumber: "01", text: "양팔을 가슴 옆에 두고 바닥에 엎드립니다.")
    
    private var exerciseInfo2 = MaeumGaGymPostureInfoLabel(titleNumber: "02", text: "복근과 둔근에 힘을 준 상태로 팔꿈치를 피며\n올라옵니다.", numberOfLines: 2)
    
    private var exerciseInfo3 = MaeumGaGymPostureInfoLabel(titleNumber: "03", text: "천천히 팔꿈치를 굽히며 시작 자세로 돌아갑니다.")
    
    public func setup(textNum1: String, textLabel1: String, textNum2: String, textLabel2: String, textNum3: String, textLabel3: String) {
        self.exerciseInfo1.updateData(text: textLabel1)
        self.exerciseInfo2.updateData(text: textLabel2)
        self.exerciseInfo3.updateData(text: textLabel3)
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
            $0.top.equalToSuperview().offset(12.0)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(32.0)
        }
        
        exerciseInfo1.snp.makeConstraints {
            $0.top.equalTo(exerciseWay.snp.bottom).offset(24.0)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        exerciseInfo2.snp.makeConstraints {
            $0.top.equalTo(exerciseInfo1.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        exerciseInfo3.snp.makeConstraints {
            $0.top.equalTo(exerciseInfo2.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}

