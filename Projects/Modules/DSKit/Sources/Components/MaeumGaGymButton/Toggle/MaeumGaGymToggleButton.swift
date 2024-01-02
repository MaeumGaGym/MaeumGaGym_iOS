import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

open class MaeumGaGymToggleButton: UIButton {
    
    public let disposeBag = DisposeBag()
    
    private let textLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.font = UIFont.Pretendard.labelLarge
        $0.textColor = .black
        $0.backgroundColor = .clear
    }
    
    public init (
        type: ToggleButtonType,
        radius: Double? = 20.0
    ) {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = radius ?? 20.0
        self.textLabel.text = type.message
        
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubviews([textLabel])
        
        snp.makeConstraints {
            $0.width.equalTo(83.0)
            $0.height.equalTo(40.0)
        }
        
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    public func buttonYesChecked() {
        self.backgroundColor = DSKitAsset.Colors.gray50.color
        textLabel.textColor = DSKitAsset.Colors.blue500.color
    }
    
    public func buttonNoChecked() {
        self.backgroundColor = .clear
        textLabel.textColor = DSKitAsset.Colors.gray400.color
    }
}
