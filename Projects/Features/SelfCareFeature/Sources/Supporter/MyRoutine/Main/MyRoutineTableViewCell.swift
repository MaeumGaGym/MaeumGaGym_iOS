import UIKit

import SnapKit
import Then

import Core
import DSKit

public class MyRoutineTableViewCell: BaseTableViewCell {
    
    static let identifier: String = "MyRoutineTableViewCell"
    
    private var containerView = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.blue50.color
        $0.layer.cornerRadius = 16.0
    }
    
    private var routineNameLabel = UILabel().then {
        $0.font = UIFont.Pretendard.labelLarge
        $0.textColor = .black
        $0.numberOfLines = 1
    }
    
    private var routineStateLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodySmall
        $0.numberOfLines = 1
        $0.textColor = DSKitAsset.Colors.gray400.color
    }
    
    private var sharedView = MGShareStateView().then {
        $0.isHidden = true
    }
    
    private let dotsButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.selfCareDots.image, for: .normal)
    }
    
    public func setup(name: String, state: RoutineState, shared: SharedState) {
        routineNameLabel.text = name
        
        routineState(routineState: state)
        SharedViewState(sharedState: shared)

        layout()
        
    }
    
    override public func layout() {
        super.layout()
        contentView.addSubview(containerView)
        containerView.addSubviews([routineNameLabel, routineStateLabel, dotsButton, sharedView])
        
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
        
        routineNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(24.0)
        }
        
        routineStateLabel.snp.makeConstraints {
            $0.top.equalTo(routineNameLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(37.0)
            $0.height.equalTo(18.0)
        }
        
        dotsButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(29.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.width.height.equalTo(24.0)
        }
        
        sharedView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(23.0)
            $0.trailing.equalTo(dotsButton.snp.leading).offset(-12.0)
            $0.width.equalTo(98.0)
            $0.height.equalTo(36.0)
        }
    }
    
    public func SharedViewState(sharedState: SharedState) {
        switch sharedState {
        case .yesShared:
            sharedView.isHidden = false
        case .notShared:
            sharedView.isHidden = true
        }
    }
    
    public func routineState(routineState: RoutineState) {
        switch routineState {
        case .useRoutine:
            routineStateLabel.text = "사용중"
            routineStateLabel.textColor = DSKitAsset.Colors.blue500.color
        case .keepRoutine:
            routineStateLabel.text = "보관중"
            routineStateLabel.textColor = DSKitAsset.Colors.gray400.color
        }
    }
    
    public func changeRoutineName(text: String) {
        routineNameLabel.text = text
    }
}
