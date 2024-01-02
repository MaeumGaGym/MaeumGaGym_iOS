import UIKit
import RxSwift
import RxCocoaRuntime
import Then
import SnapKit
import Core

open class MaeumGaGymCheckButton: BaseButton {
    
    public var textLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.font = UIFont.Pretendard.labelLarge
    }
    
    public init (
        text: String? = "",
        radius: Double? = 8.0,
        textColor: UIColor? = DSKitAsset.Colors.gray200.color,
        backColor: UIColor? =  DSKitAsset.Colors.gray400.color
    ) {
        
        super.init(frame: .zero)

        setupUI(text: text, radius: radius, textColor: textColor, backColor: backColor)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layout() {
        super.layout()
        
        self.addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.height.equalTo(58.0)
        }
    }
    
    private func setupUI(
        text: String?,
        radius: Double?,
        textColor: UIColor?,
        backColor: UIColor?
    ) {
        textLabel.text = text
        backgroundColor = backColor
        textLabel.textColor = textColor
        self.makeRounded(radius: radius ?? 8)
    }
}
