import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import DSKit

open class PostureRecommandTitleView: UIView {
    
    let disposeBag = DisposeBag()
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.Pretendard.titleMedium
        $0.textColor = .black
    }
    
    let imageView = UIImageView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray50.color
        $0.layer.cornerRadius = 8.0
    }
    
    private let seeMoreButton = MaeumGaGymSeeMoreButton()

    
    public init(
        text: String,
        image: UIImage

    ) {
        super.init(frame: .zero)
        
        titleLabel.text = text
        imageView.image = image
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews([imageView, titleLabel, seeMoreButton])
    
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
        
    }
    
}



