import UIKit

import SnapKit
import Then

import Core

open class MGTitleTextFieldView: BaseView {

    private var textLimit: Int = 0

    private var titleLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
        $0.textColor = .black
        $0.textAlignment = .left
    }

    private var containerView = BaseView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DSKitAsset.Colors.gray50.color.cgColor
        $0.layer.cornerRadius = 8.0
        $0.backgroundColor = DSKitAsset.Colors.gray25.color
    }

    public let textField = UITextField().then {
        $0.tintColor = DSKitAsset.Colors.blue500.color
        $0.font = UIFont.Pretendard.bodyLarge
    }

    private var unitLabel = MGLabel(font: UIFont.Pretendard.bodyLarge,
                                    textColor: DSKitAsset.Colors.gray600.color).then {
        $0.isHidden = true
    }

    public init (titleText: String,
                 unitText: String? = "",
                 textLimit: Int,
                 placeholder: String
    ) {
        super.init(frame: .zero)

        titleLabel.text = titleText
        if !(unitText == "") {
            unitLabel.isHidden = false
            unitLabel.changeText(text: unitText)
        }
        self.textField.placeholder = placeholder
        self.textLimit = textLimit
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func attribute() {
        super.attribute()

        textField.delegate = self
    }

    open override func layout() {
        super.layout()

        addSubviews([titleLabel, containerView])
        containerView.addSubviews([textField, unitLabel])

        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(20.0)
        }

        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.bottom.equalToSuperview()
        }

        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.0)
            $0.leading.trailing.equalToSuperview().inset(12.0)
            $0.bottom.equalToSuperview().inset(12.0)
        }

        unitLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(12.0)
            $0.height.equalTo(24.0)
        }
    }
}

extension MGTitleTextFieldView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
            containerView.layer.borderColor = DSKitAsset.Colors.blue100.color.cgColor
            containerView.backgroundColor = DSKitAsset.Colors.blue50.color
            titleLabel.textColor = DSKitAsset.Colors.blue500.color
        }

        public func textFieldDidEndEditing(_ textField: UITextField) {
            containerView.layer.borderColor = DSKitAsset.Colors.gray50.color.cgColor
            containerView.backgroundColor = DSKitAsset.Colors.gray25.color
            titleLabel.textColor = .black
        }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return updatedText.count <= textLimit
    }
}
