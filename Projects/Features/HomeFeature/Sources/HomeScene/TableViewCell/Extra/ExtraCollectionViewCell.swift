import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core
import DSKit

import Domain

import HomeFeatureInterface

public class ExtraCollectionViewCell: UICollectionViewCell, CollectoionCellID {
    
    public static var identifier: String  = "ExtraCollectionViewCell"
    
    private var iconImageView = UIImageView().then {
        $0.backgroundColor = .clear
    }

    private var titleLabel = BaseLabel().then {
        $0.font = UIFont.Pretendard.titleMedium
        $0.textColor = .black
        $0.numberOfLines = 1
    }

    private var descriptionLabel = MGLabel(font: UIFont.Pretendard.bodyMedium,
                                           textColor: DSKitAsset.Colors.gray600.color,
                                           numberOfLineCount: 0
    )

    public override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews([iconImageView,
                     titleLabel,
                     descriptionLabel])

        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(40.0)
            $0.top.equalToSuperview().offset(40.0)
            $0.leading.equalToSuperview().offset(24.0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(40.0)
            $0.leading.equalTo(iconImageView.snp.leading)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(5.0)
        }

        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with extra: ExtrasModel) {
        iconImageView.image = extra.image
        titleLabel.text = extra.titleName
        descriptionLabel.text = extra.description
    }
}
