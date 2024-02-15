import UIKit

import RxSwift

import Then
import SnapKit

import Core

open class MGAuthButton: BaseButton {

    public let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    public let textLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.font = UIFont.Pretendard.bodyMedium
    }

    public init(
        type: AuthLogoType,
        spacing: CGFloat = 8.0,
        radius: Double? = 8.0
    ) {
        super.init(frame: .zero)

        setup(type: type, spacing: spacing, radius: radius)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layout() {
        super.layout()
        self.addSubviews([iconImageView, textLabel])

        self.iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(28)
        }

        self.textLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}

private extension MGAuthButton {
    func setup(type: AuthLogoType,
                         spacing: CGFloat?,
                         radius: Double?) {
        self.textLabel.text = type.logoTitle
        self.iconImageView.image = type.imageLogo
        self.backgroundColor = type.backgroundColor
        self.layer.cornerRadius = radius ?? 8
        self.textLabel.textColor = type.titleColor
    }
}
