import UIKit
import Then
import SnapKit

public class MaeumGaGymPagingTabBarCell: UICollectionViewCell {
    
    static let identifier = "MaeumGaGymTabBarCell"
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15.0, weight: .semibold)
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
    }
        
    private lazy var underline = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0.0
    }
    
    public override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .black : .secondaryLabel
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
            underline
        ].forEach { addSubview($0) }
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        underline.snp.makeConstraints { make in
            make.height.equalTo(3.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
