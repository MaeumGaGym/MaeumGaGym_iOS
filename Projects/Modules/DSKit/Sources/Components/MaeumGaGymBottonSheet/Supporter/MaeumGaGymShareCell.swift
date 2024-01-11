import UIKit
import SnapKit
import Then

public class MaeumGaGymShareCell: UITableViewCell {
    
    public static let identifier = "MaeumGaGymShareCell"
    
    public var mainTitle = UILabel().then {
        $0.textColor = UIColor.white
        $0.font = UIFont.Pretendard.titleMedium
        $0.text = "공유"
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(mainTitle)
        
        mainTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.0)
            $0.leading.equalToSuperview().offset(20.0)
        }
    }
}
