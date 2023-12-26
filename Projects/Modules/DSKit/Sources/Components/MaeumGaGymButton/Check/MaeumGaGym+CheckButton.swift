import UIKit
import RxSwift
import RxCocoaRuntime
import Then
import SnapKit
import Core

open class MaeumGaGymCheckButton: UIButton {
    
    public let textLabel = UILabel().then {
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
        textLabel.text = text
        backgroundColor = backColor
        textLabel.textColor = textColor
        layer.cornerRadius = radius ?? 8
        setupUI()
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.height.equalTo(58.0)
        }
    }
}
