import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core
import DSKit

import Domain

import MGNetworks

public class SelfCareMenuCollectionCell: UICollectionViewCell {

    static let identifier: String = "SelfCareMenuCollectionCell"

    private var menuImageView = UIImageView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray50.color
        $0.layer.cornerRadius = 8.0
    }

    private var menuLabel = MGLabel(
        font: UIFont.Pretendard.bodyLarge,
        textColor: .black,
        isCenter: true
    )

    private var arrowImageView = UIImageView(image: DSKitAsset.Assets.rightArrow.image)

    public override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubviews([
            menuImageView,
            menuLabel,
            arrowImageView
        ])

        menuImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.0)
            $0.height.width.equalTo(40.0)
        }

        menuLabel.snp.makeConstraints {
            $0.leading.equalTo(menuImageView.snp.trailing).offset(16.0)
            $0.centerY.equalTo(menuImageView.snp.centerY)
        }

        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.0)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with menus: SelfCareMenuModel) {
        menuImageView.image = menus.menuImage
        menuLabel.changeText(text: menus.menuName)
    }

}
