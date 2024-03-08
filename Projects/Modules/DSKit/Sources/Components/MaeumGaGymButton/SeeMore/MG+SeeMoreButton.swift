import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import Core


public class MaeumGaGymSeeMoreButton: BaseButton {
    
    private let seemoreLabel = MGLabel(text: "더보기",
        font: UIFont.Pretendard.bodyMedium,
                                       textColor: DSKitAsset.Colors.gray400.color
    )
    
    private let rigthArrowImageView = UIImageView().then {
        $0.image = DSKitAsset.Assets.rightArrow.image
    }
    
    public override func layout() {
        addSubviews([seemoreLabel, rigthArrowImageView])
        seemoreLabel.snp.makeConstraints {
            $0.width.equalTo(42.0)
            $0.height.equalTo(20.0)
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        rigthArrowImageView.snp.makeConstraints {
            $0.width.height.equalTo(24.0)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(seemoreLabel.snp.trailing)
        }
    }
}
