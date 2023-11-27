import UIKit
import Then
import SnapKit

open class MaeumGaGymAgreeButton: UIButton {
    
    private let iconImageView = UIImageView().then {
        $0.image = DSKitAsset.Assets.noCheck.image
    }
    
    private let textLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    private let chooseLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = UIFont.Pretendard.bodyMedium
        $0.textColor = DSKitAsset.Colors.gray400.color
        $0.text = "(선택)"
        $0.isHidden = true
    }
    
    public init (
        text: String,
        font: UIFont? = UIFont.Pretendard.bodyMedium,
        type: Int? = 1
    ) {
        super.init(frame: .zero)
        
        self.textLabel.text = text
        self.textLabel.font = font
        switch type {
        case 1: 
            break
        default:
            chooseLabel.isHidden = false
        }
        
        setupUI()
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubviews([iconImageView, textLabel, chooseLabel])
        
        self.snp.makeConstraints {
            $0.width.equalTo(390.0)
            $0.height.equalTo(44.0)
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(28.0)
            $0.leading.equalToSuperview().offset(0.0)
            $0.centerY.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12.0)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20.0)
            $0.width.equalToSuperview()
        }
        
    }
}
