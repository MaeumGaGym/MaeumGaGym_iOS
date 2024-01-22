import UIKit
import SnapKit
import Then

open class MaeumGaGymSearchView: UIView {
    private var searchImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = DSKitAsset.Assets.postureSearch.image
    }
    
    private let searchTextField = MaeumGaGymSearchTextField()
    
    private var cancelImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = DSKitAsset.Assets.postureCancel.image
        $0.isHidden = true
    }
    
    public init (backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 8.0
        
        if (backgroundColor == DSKitAsset.Colors.gray800.color ) {
            searchImage.image = DSKitAsset.Assets.pickleSearch.image
            cancelImage.image = DSKitAsset.Assets.pickleCancel.image
        }
        self.searchTextField.placeholder = "자세 검색"
        
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func hideCancelButton() {
        self.cancelImage.isHidden = true
    }
    
    public func showCancelButton() {
        self.cancelImage.isHidden = true
    }
    
    private func setupUI() {
        self.addSubviews([searchImage, searchTextField, cancelImage])
        
        searchImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12.0)
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.width.height.equalTo(24.0)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10.0)
            $0.leading.equalTo(searchImage.snp.trailing).offset(8.0)
            $0.trailing.equalTo(cancelImage.snp.leading).offset(-8.0)
            $0.height.equalTo(40.0)
        }
        
        cancelImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12.0)
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.width.height.equalTo(24.0)
        }
    }
}
