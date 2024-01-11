import UIKit
import Then
import SnapKit

public class MaeumGaGymPagingTabBarCell: UICollectionViewCell {
    
    static let identifier = "MaeumGaGymPagingTabBarCell"
    
    private lazy var titleLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyLarge
        $0.textColor = DSKitAsset.Colors.gray400.color
        $0.textAlignment = .center
    }
    
    private lazy var grayUnderline = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray50.color
        $0.alpha = 1.0
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

private extension MaeumGaGymPagingTabBarCell {
    func setupLayout() {
        [
            titleLabel,
            grayUnderline,
            underline
        ].forEach { addSubview($0) }
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        
        grayUnderline.snp.makeConstraints { make in
            make.height.equalTo(2.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        underline.snp.makeConstraints { make in
            make.height.equalTo(2.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            make.leading.trailing.equalToSuperview().inset(14.0)
            make.bottom.equalToSuperview()
        }
    }
}
