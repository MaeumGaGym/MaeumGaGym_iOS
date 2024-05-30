import UIKit

import SnapKit
import Then

import DSKit
import Core

public class PostureDetailExplanView: BaseView {

    private var titleLabel = MGLabel(
        font: UIFont.Pretendard.titleMedium, 
        isCenter: false
    )
    
    private var contentsLabel = MGLabel(
        font: UIFont.Pretendard.bodyMedium,
        isCenter: false
    )
    
    public override func layout() {
        addSubviews([titleLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32)
        }
    }
}
