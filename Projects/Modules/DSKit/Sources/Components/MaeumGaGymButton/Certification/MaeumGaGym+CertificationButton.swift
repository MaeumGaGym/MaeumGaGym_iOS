import UIKit
import Then
import SnapKit
import Core
import RxSwift
import RxCocoa

open class MaeumGaGymCertificationButton: BaseButton {

    private let textLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }

    public init(
        text: String,
        font: UIFont? = UIFont.Pretendard.labelSmall,
        textColor: UIColor? = .black,
        radius: Double? = 8.0
    ) {
        super.init(frame: .zero)

        setupUI(text: text, font: font, textColor: textColor, radius: radius)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(text: String, font: UIFont?, textColor: UIColor?, radius: Double?) {
        textLabel.text = text
        backgroundColor = DSKitAsset.Colors.gray100.color
        layer.cornerRadius = radius ?? 8
        textLabel.textColor = textColor

        if let font = font {
            textLabel.font = font
            var topBottomInset: CGFloat = 0
            var leftRightInset: CGFloat = 0

            switch font {
            case UIFont.Pretendard.bodySmall:
                topBottomInset = 6
                leftRightInset = 12
                snp.makeConstraints {
                    $0.height.equalTo(30)
                }
            case UIFont.Pretendard.labelSmall:
                topBottomInset = 8
                leftRightInset = 12
                snp.makeConstraints {
                    $0.height.equalTo(34)
                }
            default:
                break
            }

            contentEdgeInsets = UIEdgeInsets(top: topBottomInset,
                                             left: leftRightInset,
                                             bottom: topBottomInset,
                                             right: leftRightInset)
        }

        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.numberOfLines = 0
    }
    
    open override func layout() {
        super.layout()
        
        addSubview(textLabel)

        textLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        let textWidth = textLabel.intrinsicContentSize.width
        snp.makeConstraints {
            $0.width.equalTo(textWidth + 1 * (contentEdgeInsets.left + contentEdgeInsets.right))
        }
    }
    
    private func updateButtonWidth(for text: String) {
        let textWidth = text.size(withAttributes: [.font: textLabel.font ?? UIFont.Pretendard.bodyMedium]).width

        snp.updateConstraints {
            $0.width.equalTo(textWidth + 1 * (contentEdgeInsets.left + contentEdgeInsets.right))
        }
    }

    public func setText(_ text: String) {
        setTitle(text, for: .normal)
    }
}
