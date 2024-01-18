import UIKit
import SnapKit
import Then

open class MaeumGaGymSearchTextField: UITextField {
    
    private let placeholderLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
        $0.textColor = DSKitAsset.Colors.gray300.color
        $0.contentMode = .left
        $0.text = "자세 검색"
    }
    
    public convenience init(placeholder: String) {
        self.init(frame: .zero)
        
        placeholderLabel.text = placeholder
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        configure()

        self.tintColor = DSKitAsset.Colors.blue500.color
    }
    
    private func configure() {
        addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(10.0)

        }
    }
}
