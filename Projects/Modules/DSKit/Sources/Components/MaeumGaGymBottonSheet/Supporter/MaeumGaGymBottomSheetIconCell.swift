import UIKit
import SnapKit
import Then

public class MaeumGaGymBottomSheetIconCell: UITableViewCell {
    
    static let identifier = "MaeumGaGymBottomSheetIconCell"
    
    public var iconImage = UIImageView().then {
        $0.image = UIImage(named: "icon")
        $0.tintColor = .white
    }

    public var title = UILabel().then {
        $0.text = "상어상어"
        $0.textColor = UIColor.white
        $0.font = UIFont.Pretendard.labelLarge
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
        self.backgroundColor = DSKitAsset.Colors.gray900.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(iconImage)
        contentView.addSubview(title)
        
        iconImage.snp.makeConstraints {
            $0.leading.top.equalTo(5)
            $0.centerY.equalToSuperview()
            $0.size.width.height.equalTo(28.0)
        }
        
        title.snp.makeConstraints {
            $0.leading.equalTo(iconImage.snp.trailing).offset(24.0)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(-5)
        }
    }
    
}
