import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

open class MaeumGaGymPostureTitleView: UIView {
    
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
        addSubviews([titleLabel, imageView, seeMoreButton])
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(430.0)
            $0.height.equalTo(721.0)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(0.0)
        }
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(430.0)
            $0.height.equalTo(721.0)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(0.0)
        }
        
        seeMoreButton.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(16.0)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16.0)
        }
        
    }
}
