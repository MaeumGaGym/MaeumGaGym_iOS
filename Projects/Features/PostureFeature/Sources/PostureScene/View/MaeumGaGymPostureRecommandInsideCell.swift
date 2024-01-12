import UIKit
import SnapKit
import Then

open class CustomCell: UICollectionViewCell {
    
    let imageView = UIImageView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray50.color
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 8.0
    }
    
    let label1 = UILabel().then {
        $0.textColor = .black
        $0.backgroundColor = .clear
        $0.font = UIFont.Pretendard.labelMedium
    }
    
    let label2 = UILabel().then {
        $0.textColor = DSKitAsset.Colors.gray600.color
        $0.backgroundColor = .clear
        $0.font = UIFont.Pretendard.bodyMedium
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size = CGSize(width: 148, height: 200)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(148.0)
        }
        
        label1.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(20.0)
        }
        
        label2.snp.makeConstraints {
            $0.top.equalTo(label1.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(20.0)
        }
    }
    
    func configure(image: UIImage, text1: String, text2: String) {
        imageView.image = image
        label1.text = text1
        label2.text = text2
    }
}
