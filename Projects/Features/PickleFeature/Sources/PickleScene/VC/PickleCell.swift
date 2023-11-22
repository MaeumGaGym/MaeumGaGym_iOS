import UIKit
import PickleFeatureInterface
import SnapKit
import Then
import Core

public class PickleCell: PickleCollectionViewCell {
    
    private let nameLabel = UILabel().then {
        $0.textColor = .white
    }
    
    public override func addSubViews() {
        super.addSubViews()
        
        self.contentView.addSubview(self.nameLabel)
    }
    
    public override func makeConstraints() {
        super.makeConstraints()
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(50.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
    }
    
    public override func configure(event: PickleEvent) {
        super.configure(event: event)
        print("⭐️ 이벤트: \(event)")
    }
    
    public override func configure(item: PickleItem) {
        super.configure(item: item)
        print("🖤 item: \(item)")
        
        if let reelsItem = item as? PickleItems {
            self.nameLabel.text = reelsItem.name
        }
    }
}
