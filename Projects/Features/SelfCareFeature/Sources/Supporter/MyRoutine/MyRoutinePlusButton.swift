import UIKit

import SnapKit
import Then

import DSKit
import Core

public class MyRoutinePlusButton: UIButton {
    
    private var plusImage = UIImageView().then {
        $0.image = DSKitAsset.Assets.selfCareAdd.image
    }
    
    private var textLabel = UILabel().then {
        $0.font = UIFont.Pretendard.labelLarge
        $0.text = "루틴 추가하기"
        $0.textColor = .white
        $0.contentMode = .left
    }
    
    public init (
        text: String? = "루틴 추가하기"
    ) {
        super.init(frame: .zero)
        
        textLabel.text = text
        layer.cornerRadius = 8.0
        layer.backgroundColor = DSKitAsset.Colors.blue500.color.cgColor
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
