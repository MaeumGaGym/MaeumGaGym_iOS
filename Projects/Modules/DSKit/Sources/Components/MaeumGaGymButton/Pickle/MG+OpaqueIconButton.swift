import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core

open class MGOpaqueIconButton: BaseButton {

    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private var likeCountLabel = MGLabel(font: UIFont.Pretendard.bodySmall,
                                         textColor: .white,
                                         isCenter: true
    )

    public init(
        type: PickleLogoType,
        spacing: CGFloat = 8.0,
        radius: Double? = 24.0,
        likeCount: Int? = 12000
    ) {
        super.init(frame: .zero)
        setup(type: type, spacing: spacing, radius: radius, likeCount: likeCount)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func attribute() {
        super.attribute()
        
        isUserInteractionEnabled = true
        backgroundColor = .clear
        
        for subview in subviews {
            subview.isUserInteractionEnabled = false
        }
    }
    
    public override func layout() {
        super.layout()
        
        addSubviews([iconImageView, likeCountLabel])
        
        iconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40.0)
        }

        if !likeCountLabel.isHidden {
            likeCountLabel.snp.makeConstraints {
                $0.top.equalTo(iconImageView.snp.bottom).offset(4.0)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().offset(2)
            }
        }

        snp.makeConstraints {
            $0.height.equalTo(likeCountLabel.isHidden ? 50.0 : 70.0)
        }
    }

    public func setLikeCount(_ count: Int) {
        likeCountLabel.text = formattedLikeCount(count)
    }
    
    public func pickleLogoTypeEdit(type: PickleLogoType) {
        iconImageView.image = type.imageLogo
        likeCountLabel.textColor = type.titleColor
    }
}

private extension MGOpaqueIconButton {
    func formattedLikeCount(_ count: Int) -> String {
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
    
    func setup(
        type: PickleLogoType,
        spacing: CGFloat?,
        radius: Double?,
        likeCount: Int?
    ) {
        iconImageView.image = type.imageLogo
        likeCountLabel.textColor = type.titleColor
        
        if type != .dots {
            setLikeCount(likeCount ?? 0)
        }
        
        if type == .comment {
            setLikeCount(0)
        }
        
        if type == .share {
            likeCountLabel.text = "공유"
        }
    }
}
