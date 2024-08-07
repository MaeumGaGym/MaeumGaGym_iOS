import UIKit
import Then
import SnapKit

public class MGPagingTabBarCell: UICollectionViewCell {
    
    static let identifier = "MaeumGaGymPagingTabBarCell"
    
    private lazy var titleLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyLarge
        $0.textColor = DSKitAsset.Colors.gray400.color
        $0.textAlignment = .center
    }

    private lazy var underline = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.blue500.color
        $0.alpha = 0.0
    }
    
    public override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .black : DSKitAsset.Colors.gray400.color
            underline.alpha = isSelected ? 1.0 : 0.0
        }
    }
    
    func setupView(title: String) {
        setupLayout()
        titleLabel.text = title
    }
}

private extension MGPagingTabBarCell {
    func setupLayout() {
        [
            titleLabel,
            underline
        ].forEach { addSubview($0) }
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        
        underline.snp.makeConstraints { make in
            make.height.equalTo(2.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
