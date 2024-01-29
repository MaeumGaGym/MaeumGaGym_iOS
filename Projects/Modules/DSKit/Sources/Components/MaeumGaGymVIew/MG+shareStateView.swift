import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import Core

open class MGShareStateView: BaseView {
    
    private let sharedLabel = UILabel().then {
        $0.text = "공유됨"
        $0.font = UIFont.Pretendard.labelMedium
        $0.textColor = DSKitAsset.Colors.blue500.color
    }
    
    private let sharedImage = UIImageView().then {
        $0.image = DSKitAsset.Assets.selfCareEarth.image
    }
    
    override open func attribute() {
        self.layer.cornerRadius = 18.0
        self.backgroundColor = .white
    }
    
    public override func layout() {
        addSubviews([sharedLabel, sharedImage])
        
        sharedLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.width.equalTo(42.0)
            $0.height.equalTo(20.0)
        }
        
        sharedImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.width.height.equalTo(16.0)
        }
    }
}
