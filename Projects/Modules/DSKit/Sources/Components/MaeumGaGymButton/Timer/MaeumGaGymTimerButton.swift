import UIKit
import SnapKit
import Then
import RxSwift

open class MaeumGaGymTimerButton: UIButton {
    
    public let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    public init(
        type: TimerButtonType,
        radius: Double? = 34.0
    ) {
        super.init(frame: .zero)
        
        self.iconImageView.image = type.imageLogo
        self.backgroundColor = type.backgroundColor
        self.layer.cornerRadius = radius ?? 34.0
        self.layer.borderColor = DSKitAsset.Colors.blue500.color.cgColor
        self.layer.borderWidth = 1
        
        switch radius {
        case 34.0:
            snp.makeConstraints {
                $0.width.height.equalTo(68.0)
            }
            break
        case 40.0:
            snp.makeConstraints {
                $0.width.height.equalTo(80.0)
            }
            break
        default:
            break
        }
        
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
