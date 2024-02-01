import UIKit

import SnapKit
import Then

import Core

public class MGTitleTextView: BaseView {
    
    private var titleLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
        $0.textAlignment = .left
        $0.textColor = .black
        $0.numberOfLines = 1
    }
    
    private var textField = MGTitleTextField()
    
    public init (
        type: TitleTextFieldType
    ) {
        super.init(frame: .zero)
        titleLabel.text = type.titleText
        textField.setPlaceholder(placeholder: type.placeHolder)
        
        layout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layout() {
        addSubviews([titleLabel, textField])
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(20.0)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
}
