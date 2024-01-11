import UIKit
import SnapKit

public class TestCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    func setImageView() {
        backgroundColor = .systemGroupedBackground
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
}
