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
    
    private var containerView = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray25.color
        $0.layer.cornerRadius = 8.0
        $0.layer.borderColor = DSKitAsset.Colors.gray50.color.cgColor
        $0.layer.borderWidth = 1.0
    }

    private var textField = MGTitleTextField()

    public override func layout() {
        addSubviews([titleLabel, containerView])
        containerView.addSubviews([textField])

        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(20.0)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.0)
            $0.trailing.leading.equalToSuperview().inset(12.0)
        }
    }
}

public extension MGTitleTextView {
    func setup(
        titleText: String,
        placeholder: String,
        text: String
    ) {
        titleLabel.text = titleText
        textField.text = text
    }
}
