import UIKit

import Then
import SnapKit

import Core

open class MGProfileButton: BaseButton {
    
    private let arrowImageView = UIImageView(image: DSKitAsset.Assets.rightArrow.image)
    
    public init(
        buttonTitle: String
    ) {
        super.init(frame: .zero)
        self.setTitle(text: buttonTitle)
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func attribute() {
        super.attribute()
        self.contentHorizontalAlignment = .leading
        self.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        self.titleLabel?.font = UIFont.Pretendard.bodyLarge
        self.setColor(backColor: DSKitAsset.Colors.gray25.color)
    }
    open override func layout() {
        super.layout()
        self.addSubview(arrowImageView)
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(24.0)
        }
    }
    
}
