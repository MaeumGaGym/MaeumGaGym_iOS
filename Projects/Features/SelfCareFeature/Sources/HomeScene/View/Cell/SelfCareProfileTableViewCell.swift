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
        profileImage: MGProfileImage(
            type: .custom,
            customImage: DSKitAsset.Assets.basicProfileIcon.image
        ), profileType: .bigProfile
    )

    private let userNameLabel = MGLabel(
        font: UIFont.Pretendard.labelLarge,
        textColor: .black
    )

    private var userTimerLabel = MGLabel(
        font: UIFont.Pretendard.bodyMedium,
        textColor: DSKitAsset.Colors.gray400.color
    )

    private var userBageView = MGProfileView(
        profileImage: MGProfileImage(
            type: .custom,
            customImage: DSKitAsset.Assets.appleLogo.image
        ), profileType: .bage
    )

    private let arrowImageView = UIImageView(image: DSKitAsset.Assets.rightArrow.image)

    public func configure(
        with message: SelfCareDetailProfileModel
    ) {
        userNameLabel.changeText(text: message.userName)
        userTimerLabel.changeText(text: "\(message.userWakaTime)시간")
    }

    public override func layout() {
        super.layout()

        addSubviews([
            profileImageView,
            userNameLabel,
            userTimerLabel,
            userBageView,
            arrowImageView
        ])

        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.0)
        }

        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12.0)
        }

        userBageView.snp.makeConstraints {
            $0.leading.equalTo(userNameLabel.snp.trailing).offset(8.0)
            $0.centerY.equalTo(userNameLabel.snp.centerY)
        }

        userTimerLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(2.0)
            $0.leading.equalTo(userNameLabel.snp.leading)
        }

        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
