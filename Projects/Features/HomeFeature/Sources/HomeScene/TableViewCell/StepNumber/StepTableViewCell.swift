import UIKit

import RxSwift
import RxCocoa
import RxFlow

import Then
import SnapKit

import Core
import DSKit

import Domain

import MindGymKit

import HomeFeatureInterface

public class StepTableViewCell: BaseTableViewCell, CollectoionCellID {
    
    static public var identifier: String = "StepTableViewCell"
    
    private lazy var stepNumberTitle = MGLabel(
        numberOfLineCount: 1
    ).then {
        $0.changeFont(font: UIFont.Pretendard.titleLarge)
        $0.changeTextColor(color: DSKitAsset.Colors.blue800.color)
    }
    
    private let workTitle = MGLabel(text: "걸음",
                                    numberOfLineCount: 1
    ).then {
        $0.changeFont(font: UIFont.Pretendard.titleSmall)
        $0.changeTextColor(color: DSKitAsset.Colors.gray600.color)
    }
    
    public func configure(with step: StepModel) {
        let formattedStepCount = formattedLikeCount(2000)
        stepNumberTitle.changeText(text: formattedStepCount)
    }
    
    public override func commonInit() {
        super.commonInit()
        
        rx.deallocated
            .bind { [weak self] in
                self?.disposeBag = DisposeBag()
            }
            .disposed(by: disposeBag)
    }
    
    public override func attribute() {
        super.attribute()
        
        backgroundColor = DSKitAsset.Colors.gray25.color
        
    }
    
    public override func layout() {
        super.layout()
        
        setupCornerRadiusAndBackground()
        contentView.addSubviews([stepNumberTitle, workTitle])
        
        stepNumberTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(28.0)
        }
        
        workTitle.snp.makeConstraints {
            $0.bottom.equalTo(stepNumberTitle.snp.bottom).offset(-5)
            $0.leading.equalTo(stepNumberTitle.snp.trailing).offset(12.0)
        }
    }
}

extension StepTableViewCell {
    private func formattedLikeCount(_ count: Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .decimal
        
        if count < 1000 {
            return "\(count)"
        } else {
            return formatter.string(from: NSNumber(value: count)) ?? ""
        }
    }
}
