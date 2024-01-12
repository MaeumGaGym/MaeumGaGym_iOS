import UIKit
import Then
import SnapKit

public class MaeumGaGymeBannerCell: UICollectionViewCell {
    
    static var identifier: String = "MaeumGaGymeBannerCell"
    
    private lazy var bannerImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MaeumGaGymeBannerCell {
    func configure(with bannerImage: UIImage) {
         bannerImageView.image = bannerImage
     }
    
    private func configureUI() {
        self.contentView.addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
