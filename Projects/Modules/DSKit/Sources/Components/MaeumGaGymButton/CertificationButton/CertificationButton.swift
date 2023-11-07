import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import Core
import DSKit

open class CertificationButton: UIButton {
    
    private var width: Float = 0
    private var height: Float = 0

    private let textLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.font = UIFont.Pretendard.bodyMedium
    }

    public init(
        widthValue: Float,
        heightValue: Float,
        text: String,
        font: UIFont,
        radius: Double? = 8.0
    ) {
        super.init(frame: .zero)
        
        width = widthValue
        height = heightValue

        self.textLabel.text = text
        self.backgroundColor = DSKitAsset.Colors.gray100.color
        self.layer.cornerRadius = radius ?? 8
        self.textLabel.textColor = UIColor.black
        self.textLabel.font = font
        setupViews()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [textLabel].forEach { self.addSubview($0)}

        self.textLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.snp.makeConstraints {
            $0.width.equalTo(width)
            $0.height.equalTo(height)
        }
        
    }
}

