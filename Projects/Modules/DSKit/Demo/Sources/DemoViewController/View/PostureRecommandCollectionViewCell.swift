import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import DSKit

open class PostureRecommandCollectionViewCell: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
    
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
    
    public init(
        text: String,
        image: UIImage,
        cellData: [(image: UIImage, text1: String, text2: String)]
    ) {
        super.init(frame: .zero)
        
        collectionViewCell = MaeumGaGymPostureRecommandCollectionViewCell(cellData: cellData)
        
        titleLabel.text = text
        imageView.image = image
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews([backView ,imageView, collectionViewCell])
        backView.addSubviews([imageView, titleLabel, seeMoreButton])
        
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
}

