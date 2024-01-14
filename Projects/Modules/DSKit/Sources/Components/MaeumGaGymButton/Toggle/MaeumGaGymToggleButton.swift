import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import Core

public class MaeumGaGymToggleButton: BaseButton {

    private let textLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }

    public init(type: ToggleButtonType) {
        super.init(frame: .zero)
        setupUI(type: type)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(type: ToggleButtonType) {
        self.layer.cornerRadius = type.radius
        self.setupButton(type: type)

        self.addSubviews([textLabel])

        self.textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    public func buttonYesChecked(type: ToggleButtonType) {
        self.backgroundColor = type.checkedBackgroundColor
        self.textLabel.font = type.checkedTextFont
        self.textLabel.textColor = type.checkedTextColor
    }

    public func buttonNoChecked(type: ToggleButtonType) {
        self.backgroundColor = type.backgroundColor
        self.textLabel.font = type.textFont
        self.textLabel.textColor = type.textColor
    }

    private func setupButton(type: ToggleButtonType) {
        self.backgroundColor = type.backgroundColor
        self.textLabel.font = type.textFont
        self.textLabel.text = type.message
        self.textLabel.textColor = type.textColor
    }
}
