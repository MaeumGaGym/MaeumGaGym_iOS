import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import Core

open class MaeumGaGymOpaqueIconButton: UIButton {

    private let iconOpaqueBackgroudView = UIView().then {
        $0.backgroundColor = .red
    }

    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let likeCountLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .white
    }

    public init(
        type: PickleLogoType,
        spacing: CGFloat = 8.0,
        radius: Double? = 24.0,
        likeCount: Int? = 12000
    ) {
        super.init(frame: .zero)

        self.iconImageView.image = type.imageLogo
        self.likeCountLabel.textColor = type.titleColor
        self.backgroundColor = .clear
        iconOpaqueBackgroudView.backgroundColor = type.backgroundColor
        iconOpaqueBackgroudView.layer.cornerRadius = CGFloat(radius ?? 8)
        setupViews()

        if type != .share && type != .dots {
            setLikeCount(likeCount ?? 0)
        }
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [iconOpaqueBackgroudView, iconImageView, likeCountLabel].forEach { self.addSubview($0)}

        self.iconOpaqueBackgroudView.snp.makeConstraints {
            $0.height.width.equalTo(48.0)
            $0.centerX.equalToSuperview()
        }

        self.iconImageView.snp.makeConstraints {
            $0.centerX.equalTo(iconOpaqueBackgroudView.snp.centerX)
            $0.centerY.equalTo(iconOpaqueBackgroudView.snp.centerY)
        }

        if !likeCountLabel.isHidden {
            self.likeCountLabel.snp.makeConstraints {
                $0.top.equalTo(iconOpaqueBackgroudView.snp.bottom).offset(4.0)
                $0.centerX.equalToSuperview()
            }
        }

        self.snp.makeConstraints {
            $0.height.equalTo(likeCountLabel.isHidden ? 48.0 : 70.0)
        }
    }

    public func setLikeCount(_ count: Int) {
        likeCountLabel.text = formattedLikeCount(count)
    }

    private func formattedLikeCount(_ count: Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1

        let thousand = 1000
        let tenThousand = 10000

        if count < thousand {
            return "\(count)"
        } else if count < tenThousand {
            let value = Double(count) / Double(thousand)
            return "\(formatter.string(from: NSNumber(value: value)) ?? "")천"
        } else {
            let value = Double(count) / Double(tenThousand)
            return "\(formatter.string(from: NSNumber(value: value)) ?? "")만"
        }
    }
}
