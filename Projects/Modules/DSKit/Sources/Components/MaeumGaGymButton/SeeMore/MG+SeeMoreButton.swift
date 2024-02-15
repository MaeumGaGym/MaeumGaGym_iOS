import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import Core


public class MaeumGaGymSeeMoreButton: BaseButton {
    
    private let seemoreLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
        $0.textColor = DSKitAsset.Colors.gray400.color
        $0.text = "더보기"
    }
    
    private let rigthArrowImageView = UIImageView().then {
        $0.image = DSKitAsset.Assets.right.image
    }
    
    public init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubviews([seemoreLabel, rigthArrowImageView])
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
