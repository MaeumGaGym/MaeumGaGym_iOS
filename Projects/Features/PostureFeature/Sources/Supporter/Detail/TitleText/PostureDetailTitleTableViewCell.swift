import UIKit
import SnapKit
import Then
import DSKit

public class PostureDetailTitleTableViewCell: UITableViewCell {
    
    static let identifier: String = "PostureDetailTitleTableViewCell"
    
    private var englishTitle = UILabel().then {
        $0.font = UIFont.Pretendard.titleMedium
        $0.textColor = DSKitAsset.Colors.gray600.color
        $0.textAlignment = .left
    }
    
    private var koreanTitle = UILabel().then {
        $0.font = UIFont.Pretendard.titleLarge
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    public func setup(englishText: String, koreanText: String) {
        self.englishTitle.text = englishText
        self.koreanTitle.text = koreanText
        
        addViews()
        setupViews()
    }
    
    private func addViews() {
        [
            englishTitle,
            koreanTitle
        ].forEach { contentView.addSubview($0) }
    }
    
    private func setupViews() {
        englishTitle.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(32.0)
            $0.top.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(20.0)
        }
        
        koreanTitle.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(48.0)
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(20.0)
        }
    }
}
