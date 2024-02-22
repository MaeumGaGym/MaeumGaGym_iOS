import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core
import DSKit

import Domain

public class SelfCareProfileTableViewCell: BaseTableViewCell {

    static public var identifier: String = "SelfCareProfileTableViewCell"

    private let profileImageView = MGProfileView(
        profileImage: MGProfileImage(type: .custom,
                                     customImage: DSKitAsset.Assets.basicProfile.image),
        profileType: .bigProfile
    )

    private let userNameLabel = UILabel().then {
        $0.font = UIFont.Pretendard.labelLarge
        $0.textColor = .black
    }

    private var userTimerLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
        $0.textColor = DSKitAsset.Colors.gray400.color
    }

    private var userBageView = MGProfileView(
        profileImage: MGProfileImage(type: .custom,
                                     customImage: DSKitAsset.Assets.appleLogo.image),
        profileType: .bage
    )

    public func configure(with message: SelfCareProfileModel) {
        profileImageView.configureImage(with: MGProfileImage(type: .custom, customImage: message.userImage))
        userNameLabel.text = message.userName
        userTimerLabel.text = message.userTimer
        userBageView.configureImage(with: MGProfileImage(type: .custom, customImage: message.userBage))
    }

    public override func layout() {
        super.layout()

        addSubviews([profileImageView, userNameLabel, userTimerLabel, userBageView])

        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.0)
        }

        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12.0)
            $0.top.equalTo(profileImageView.snp.top)
        }

        userBageView.snp.makeConstraints {
            $0.leading.equalTo(userNameLabel.snp.trailing).offset(8.0)
            $0.centerY.equalTo(userNameLabel.snp.centerY)
        }

        userTimerLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(2.0)
            $0.leading.equalTo(userNameLabel.snp.leading)
        }
    }
}
