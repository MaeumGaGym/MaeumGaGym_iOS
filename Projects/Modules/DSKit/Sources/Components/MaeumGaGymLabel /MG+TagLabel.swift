import UIKit

import SnapKit
import Then

import Core

open class MGTagLabel: BaseLabel {

    private var textLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.backgroundColor = .clear
        $0.textColor = DSKitAsset.Colors.blue500.color
        $0.font = UIFont.Pretendard.labelMedium
    }

    public init() {
        super.init(frame: .zero)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func attribute() {
        super.attribute()

        layer.cornerRadius = 18.0
        clipsToBounds = true
        backgroundColor = DSKitAsset.Colors.gray50.color
    }

    open override func layout() {
        super.layout()

        addSubviews([textLabel])

        textLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(20.0)
            $0.center.equalToSuperview()
        }
    }
}

public extension MGTagLabel {
    func updateData(
        text: String,
        textcolor: UIColor? = DSKitAsset.Colors.blue500.color,
        backgroundColor: UIColor? = DSKitAsset.Colors.gray50.color,
        cornerRadius: Double? = 18.0,
        font: UIFont? = UIFont.Pretendard.labelMedium
    ) {
        self.textLabel.text = text
        self.textLabel.textColor = textcolor
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius ?? 18.0
        self.textLabel.font = font
    }
}
