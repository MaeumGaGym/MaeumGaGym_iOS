import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import Core

open class MaeumGaGymAuthButton: UIButton {

    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let textLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.font = UIFont.Pretendard.bodyMedium
    }

    public init(
        image: UIImage? = nil,
        title: String? = nil,
        spacing: CGFloat = 8.0,
        backgorundColor: UIColor?,
        ridus: Double? = 8.0,
        titleColor: UIColor?
    ) {
        super.init(frame: .zero)

        self.textLabel.text = title
        self.iconImageView.image = image
        self.backgroundColor = backgorundColor
        self.layer.cornerRadius = ridus ?? 8
        self.textLabel.textColor = titleColor
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

