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
        setup(type: type, radius: radius ?? defaultRadius)
        setupLayout(radius: radius)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MGTimerButton {
    func setup(type: TimerButtonType, radius: Double) {
        iconImageView.image = type.imageLogo
        backgroundColor = type.backgroundColor
        layer.cornerRadius = radius
        layer.borderColor = DSKitAsset.Colors.blue500.color.cgColor
        layer.borderWidth = 1
    }

    func setupLayout(radius: Double?) {
        let buttonRadius = radius ?? defaultRadius
        snp.makeConstraints {
            $0.width.height.equalTo(buttonRadius * 2)
        }

        addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
