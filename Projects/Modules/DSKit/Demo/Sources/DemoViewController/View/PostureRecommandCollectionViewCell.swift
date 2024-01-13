import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import DSKit

open class PostureRecommandCollectionViewCell: UICollectionViewCell {
    
    static public let identifier = "PostureRecommandCollectionViewCell"


    private let backView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.Pretendard.titleMedium
        $0.textColor = .black
    }
    
    let imageView = UIImageView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray50.color
        $0.layer.cornerRadius = 8.0
    }
    
    private let seeMoreButton = MaeumGaGymSeeMoreButton()

    private var collectionViewCell: MaeumGaGymPostureRecommandView!
    
    private func setupUI() {
        addSubviews([backView ,imageView, collectionViewCell])
        backView.addSubviews([imageView, titleLabel, seeMoreButton])
        
        snp.makeConstraints {
            $0.width.equalTo(430.0)
            $0.height.equalTo(340.0)
        }
        
        backView.snp.makeConstraints {
            $0.width.equalToSuperview().inset(20.0)
            $0.height.equalTo(80.0)
            $0.top.equalToSuperview().offset(20.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
    
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(40.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(89.0)
            $0.height.equalTo(32.0)
            $0.leading.bottom.equalToSuperview()
        }
        
        seeMoreButton.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.width.equalTo(74.0)
            $0.height.equalTo(24.0)
        }
        
        collectionViewCell.snp.makeConstraints {
            $0.top.equalTo(seeMoreButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    public func configure(titleData: (String, UIImage), cellData: [(UIImage, String, String)]) {
        titleLabel.text = titleData.0
        imageView.image = titleData.1
        collectionViewCell = MaeumGaGymPostureRecommandView(cellData: cellData)
        setupUI()
    }
}

