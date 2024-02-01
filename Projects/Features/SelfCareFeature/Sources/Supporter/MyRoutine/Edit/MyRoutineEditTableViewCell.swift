import UIKit

import SnapKit
import Then

import Core
import DSKit

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
    
    private var deleteButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.selfCareDelete.image, for: .normal)
    }
    
    private let numberCountView = MyRoutineCountView(type: .number)
    
    private let setCountView = MyRoutineCountView(type: .set)
    
    public func setup(image: UIImage, name: String) {
        exerciseImage.image = image
        exerciseNameLabel.text = name
        
        layout()
    }
    
    public override func layout() {
        addSubview(containerView)
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
