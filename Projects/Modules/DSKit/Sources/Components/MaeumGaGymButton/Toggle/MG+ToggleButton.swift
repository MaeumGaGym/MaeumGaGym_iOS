import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import Core

public class MGToggleButton: BaseButton {

    private let textLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }

    public init(type: ToggleButtonType) {
        super.init(frame: .zero)
        setup(type: type)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layout() {
        addSubviews([textLabel])

        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    public func buttonYesChecked(type: ToggleButtonType) {
        backgroundColor = type.checkedBackgroundColor
        textLabel.font = type.checkedTextFont
        textLabel.textColor = type.checkedTextColor
    }

    public func buttonNoChecked(type: ToggleButtonType) {
        backgroundColor = type.backgroundColor
        textLabel.font = type.textFont
        textLabel.textColor = type.textColor
    }

    public func setupButton(type: ToggleButtonType) {
        backgroundColor = type.backgroundColor
        textLabel.font = type.textFont
        textLabel.text = type.message
        textLabel.textColor = type.textColor
    }
}

private extension MGToggleButton {
    func setup(type: ToggleButtonType) {
        layer.cornerRadius = type.radius
        setupButton(type: type)
    }
}
