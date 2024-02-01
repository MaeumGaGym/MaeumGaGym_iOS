import UIKit

import SnapKit
import Then

open class MGTitleTextField: UITextField {
    
    private let placeholderLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyLarge
        $0.textColor = DSKitAsset.Colors.gray400.color
        $0.contentMode = .left
    }
    
    public convenience init(placeholder: String) {
        self.init(frame: .zero)
        
        placeholderLabel.text = placeholder
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        configure()

        tintColor = .black
        backgroundColor = DSKitAsset.Colors.gray25.color
        layer.cornerRadius = 8.0
        layer.borderColor = DSKitAsset.Colors.gray50.color.cgColor
        layer.borderWidth = 1.0
    }
    
    private func configure() {
        addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12.0)
            $0.height.equalTo(24.0)
        }
    }
}

