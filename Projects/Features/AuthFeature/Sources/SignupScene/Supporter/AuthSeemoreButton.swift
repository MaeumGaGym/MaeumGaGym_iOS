import UIKit

import SnapKit
import Then

import RxCocoa
import Core
import DSKit

public class AuthSeemoreButton: BaseButton {
        
    private var textLabel = MGLabel(text: "자세히 보기", font: UIFont.Pretendard.labelSmall, textColor: DSKitAsset.Colors.gray300.color, isCenter: true)
    
    private var lineView = MGLine(lineColor: DSKitAsset.Colors.gray300.color, lineWidth: 1.0)
    
    public override func layout() {
        super.layout()
        addSubviews([textLabel, lineView])
        
        textLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13.0)
            $0.leading.trailing.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1.0)
        }
    }
}
