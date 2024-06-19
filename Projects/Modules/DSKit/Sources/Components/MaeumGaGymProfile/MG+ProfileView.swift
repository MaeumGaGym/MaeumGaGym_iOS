import UIKit

import SnapKit
import RxCocoa
import RxSwift
import Kingfisher

open class MGProfileView: UIView {
    
    private var profileImageView = UIImageView()
    public private(set) var profileImage: MGProfileImage?
    private let profileType: MGProfileType
    
    public init (
        profileImage: MGProfileImage,
        profileType: MGProfileType
    ) {
        self.profileImage = profileImage
        self.profileType = profileType
        
        super.init(frame: .zero)
        
        configureLayout()
        configureImage(with: profileImage)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if let image = self.profileImage?.image {
            self.profileImageView.image = image
        }
        
        self.layer.cornerRadius = self.profileType.radius
        self.clipsToBounds = true
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(self.profileType.size)
        }
        
    }
    
    private func configureLayout() {
        addSubview(profileImageView)
    }
    
    public func configureImage(with maeumGaGymProfileImage: MGProfileImage) {
        self.profileImage = maeumGaGymProfileImage
        
        switch maeumGaGymProfileImage.type {
        case .custom:
            if let customImg = maeumGaGymProfileImage.customImage {
                self.profileImageView.image = customImg
            } else {
                self.profileImageView.image = DSKitAsset.Assets.blHomeTapBar.image
                self.backgroundColor = DSKitAsset.Colors.gray50.color
            }
        }
    }
}
