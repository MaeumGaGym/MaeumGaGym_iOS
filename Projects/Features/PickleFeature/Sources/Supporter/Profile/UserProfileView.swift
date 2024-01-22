import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import DSKit

open class UserProfileView: UIView {
    
    private lazy var userNameTitle = UILabel().then {
        $0.numberOfLines = 1
        $0.backgroundColor = .clear
    }
    
    private lazy var smallProfile = MGProfileView(profileImage: MGProfileImage(type: .custom, customImage: nil), profileType: .smallProfile)
    
    public init(
        userName: String,
        userProfileImage: UIImage? = DSKitAsset.Assets.basicProfile.image
    ) {
        super.init(frame: .zero)
        
        setupUI(text: userName, image: userProfileImage ?? DSKitAsset.Assets.basicProfile.image)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        configureLayout()

        smallProfile.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
            $0.width.equalTo(36)
            $0.height.equalTo(36)
        }

        userNameTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(smallProfile.snp.right).offset(8)
            $0.width.equalTo(107)
            $0.height.equalTo(36)
        }
    }
    
    private func configureLayout() {
        addSubviews([
            userNameTitle,
            smallProfile
        ])
    }
    
    private func setupUI(text: String, image: UIImage) {
        userNameTitle.text = "\(text)"
        smallProfile.configureImage(with: .init(type: .custom, customImage: image))
    }
}
