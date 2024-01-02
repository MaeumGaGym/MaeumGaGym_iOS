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
        $0.font = UIFont.Pretendard.labelLarge
        $0.textColor = .black
        $0.backgroundColor = .clear
    }

    private let defaultRadius: Double = 20.0

    public init(type: ToggleButtonType, radius: Double? = nil) {
        super.init(frame: .zero)
        setupUI(type: type, radius: radius ?? defaultRadius)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(type: ToggleButtonType, radius: Double) {
        self.layer.cornerRadius = radius
        self.textLabel.text = type.message

        self.addSubviews([textLabel])

        self.snp.makeConstraints {
            $0.width.equalTo(83.0)
            $0.height.equalTo(40.0)
        }

        self.textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    public func buttonYesChecked() {
        updateButtonStyle(backgroundColor: DSKitAsset.Colors.gray50.color, textColor: DSKitAsset.Colors.blue500.color)
    }

    public func buttonNoChecked() {
        updateButtonStyle(backgroundColor: .clear, textColor: DSKitAsset.Colors.gray400.color)
    }

    private func updateButtonStyle(backgroundColor: UIColor, textColor: UIColor) {
        self.backgroundColor = backgroundColor
        textLabel.textColor = textColor
    }
}
