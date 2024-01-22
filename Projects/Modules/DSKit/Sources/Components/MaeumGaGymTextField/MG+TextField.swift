import UIKit
import Then
import SnapKit
import Core
import RxSwift
import RxCocoa

open class MGTextField: UITextField {

    private let disposeBag = DisposeBag()

    public let placeholderLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyLarge
        $0.textColor = DSKitAsset.Colors.gray400.color
    }

    public let underlineView = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray400.color
    }

    public let errorLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyTiny
        $0.textColor = DSKitAsset.Colors.red500.color
        $0.isHidden = true
    }

    public var showError: Bool = false {
        didSet {
            errorLabel.isHidden = !showError
            underlineView.backgroundColor = showError ? UIColor.red : UIColor.black
            errorLabel.textColor = showError ? UIColor.red : UIColor.black
        }
    }

    public var errorMessage: String? {
        didSet {
            errorLabel.text = errorMessage
        }
    }
  
    public var nameErrorType: TextFieldErrorType.Name? {
        didSet {
            if let errorType = nameErrorType {
                errorMessage = errorType.message
                showError = errorType.showError
            }
        }
    }
    
    public override var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
            super.placeholder = ""
        }
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

        delegate = self

        self.tintColor = .black
    }
    
    private func configure() {
        addSubview(placeholderLabel)
        addSubview(underlineView)
        addSubview(errorLabel)
        
        placeholderLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(underlineView.snp.top).offset(-8.0)
            $0.height.equalToSuperview().multipliedBy(0.7)
        }

        underlineView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(390.0)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        errorLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(underlineView.snp.bottom).offset(8.0)
        }
        
    }
}

extension MGTextField: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            
            self.underlineView.backgroundColor = DSKitAsset.Colors.blue500.color
            self.placeholderLabel.font = UIFont.Pretendard.bodySmall
            self.placeholderLabel.snp.updateConstraints {
                $0.bottom.equalTo(self.underlineView.snp.top).offset(-(self.placeholderLabel.frame.size.height + 4))
            }
            self.layoutIfNeeded()
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            UIView.animate(withDuration: 0.3) {
                self.underlineView.backgroundColor = DSKitAsset.Colors.gray400.color
                self.placeholderLabel.font = UIFont.Pretendard.bodyLarge
                self.placeholderLabel.snp.updateConstraints {
                    $0.bottom.equalTo(self.underlineView.snp.top).offset(-4)
                }
                self.layoutIfNeeded()
            }
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            _ = touch.location(in: self)
        }
    }
}
