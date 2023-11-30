import UIKit
import RxSwift
import RxCocoaRuntime
import Then
import SnapKit
import Core

open class MaeumGaGymAuthButton: UIButton {

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

        self.textLabel.text = type.logoTitle
        self.iconImageView.image = type.imageLogo
        self.backgroundColor = type.backgroundColor
        self.layer.cornerRadius = radius ?? 8
        self.textLabel.textColor = type.titleColor
        setupViews()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [iconImageView, textLabel].forEach { self.addSubview($0)}

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

