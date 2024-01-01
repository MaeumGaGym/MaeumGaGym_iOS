import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import Core

open class MaeumGaGymOpaqueIconButton: UIButton {

    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let likeCountLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.Pretendard.bodySmall
        $0.textColor = .white
    }

    public init(
        type: PickleLogoType,
        spacing: CGFloat = 8.0,
        radius: Double? = 24.0,
        likeCount: Int? = 12000
    ) {
        super.init(frame: .zero)
        
        self.isUserInteractionEnabled = true

        self.iconImageView.image = type.imageLogo
        self.likeCountLabel.textColor = type.titleColor
        self.backgroundColor = .clear
        
        setupViews()

        if type != .dots {
            setLikeCount(likeCount ?? 0)
        }
        
        if type == .comment {
            setLikeCount(0)
        }
        
        if type == .share {
            likeCountLabel.text = "공유"
        }
        
        for subview in subviews {
            subview.isUserInteractionEnabled = false
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [iconImageView, likeCountLabel].forEach { self.addSubview($0)}

        self.iconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40.0)
        }

        if !likeCountLabel.isHidden {
            self.likeCountLabel.snp.makeConstraints {
                $0.top.equalTo(iconImageView.snp.bottom).offset(4.0)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().offset(2)
            }
        }

        self.snp.makeConstraints {
            $0.height.equalTo(likeCountLabel.isHidden ? 50.0 : 70.0)
        }
    }

    public func setLikeCount(_ count: Int) {
        likeCountLabel.text = formattedLikeCount(count)
    }
    
    public func pickleLogoTypeEdit(type: PickleLogoType) {
        self.iconImageView.image = type.imageLogo
        self.likeCountLabel.textColor = type.titleColor
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
