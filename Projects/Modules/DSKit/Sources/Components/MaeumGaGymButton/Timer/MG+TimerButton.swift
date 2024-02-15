import UIKit

import RxSwift

import SnapKit
import Then

import Core

public class MGTimerButton: BaseButton {

    public let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let defaultRadius: Double = 34.0

    public init(type: TimerButtonType, radius: Double? = nil) {
        super.init(frame: .zero)
        setupUI(type: type, radius: radius ?? defaultRadius)
        setupLayout(radius: radius)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(type: TimerButtonType, radius: Double) {
        self.iconImageView.image = type.imageLogo
        self.backgroundColor = type.backgroundColor
        self.layer.cornerRadius = radius
        self.layer.borderColor = DSKitAsset.Colors.blue500.color.cgColor
        self.layer.borderWidth = 1
    }

    private func setupLayout(radius: Double?) {
        let buttonRadius = radius ?? defaultRadius
        self.snp.makeConstraints {
            $0.width.height.equalTo(buttonRadius * 2)
        }

        self.addSubview(iconImageView)
        self.iconImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
