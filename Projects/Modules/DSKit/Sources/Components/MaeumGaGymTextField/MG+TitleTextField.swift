import UIKit

import SnapKit
import Then

open class MGTitleTextField: UITextField, UITextFieldDelegate{
    
    private let placeholderLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyLarge
        $0.textColor = DSKitAsset.Colors.gray400.color
        $0.contentMode = .left
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
        
    }
    
    private func configure() {
        addSubview(placeholderLabel)

        placeholderLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(24.0)
        }
    }

    public func setPlaceholder(placeholder: String) {
        placeholderLabel.text = placeholder
    }
}

public extension MGTitleTextField {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {

            self.backgroundColor = DSKitAsset.Colors.blue500.color
        }
        if textField.text != "" {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
        self.layoutIfNeeded()
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            let currentText = textField.text ?? ""
//            guard let stringRange = Range(range, in: currentText) else { return false }
//            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//
//            placeholderLabel.isHidden = !updatedText.isEmpty
//
//            return true
//        }
}

