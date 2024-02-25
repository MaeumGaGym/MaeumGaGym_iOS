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

    static let identifier: String = SelfCareResourcesService.identifier.selfCareMenuCollectionCell

    private var menuImageView = UIImageView().then {
        $0.layer.cornerRadius = 8.0
    }

    private var menuLabel = MGLabel(textColor: .black,
                                    isCenter: true
    )
// 보류
//    private var arrowImageView = UIImageView().then {
//        $0.image = UIImage(systemName: "chevron.right")
//        $0.tintColor = .gray
//    }
    public override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubviews([menuImageView,
                     menuLabel])

        menuImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.0)
            $0.height.width.equalTo(40.0)
        }

        menuLabel.snp.makeConstraints {
            $0.leading.equalTo(menuImageView.snp.trailing).offset(16.0)
            $0.centerY.equalTo(menuImageView.snp.centerY)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with menus: SelfCareMenuModel) {
        menuImageView.image = menus.menuImage
        menuLabel.text = menus.menuName
    }
}
