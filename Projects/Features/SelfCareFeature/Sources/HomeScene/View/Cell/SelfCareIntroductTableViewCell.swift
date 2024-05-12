import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core
import DSKit

import Domain

import MGNetworks

public class SelfCareIntroductTableViewCell: BaseTableViewCell {

    static public var identifier: String = "SelfCareIntroductTableViewCell"

    private let titleImageView = MGProfileView(
        profileImage: MGProfileImage(
            type: .custom,
            customImage: DSKitAsset.Assets.mainLogo.image
        ), profileType: .smallProfile
    )

    private let mainTitle = MGLabel(font: UIFont.Pretendard.titleLarge)

    private let subTitle = MGLabel(
        font: UIFont.Pretendard.bodyMedium,
        textColor: DSKitAsset.Colors.gray600.color,
        isCenter: false,
        numberOfLineCount: 0
    )

    private lazy var lineView = MGLine(
        lineColor: DSKitAsset.Colors.gray25.color,
        lineWidth: self.frame.width,
        lineHeight: 8
    )

    public func configure(with message: SelfCareIntroductModel) {
        titleImageView.configureImage(
            with: MGProfileImage(
                type: .custom,
                customImage: message.image
            )
        )
        mainTitle.changeText(text: message.mainText)
        subTitle.changeText(text: message.subText)
    }

    public override func attribute() {
        super.attribute()

        backgroundColor = .white
        setupRxBindings()
    }

    public override func layout() {
        super.layout()

        addSubviews([
            titleImageView,
            mainTitle,
            subTitle,
            lineView
        ])

        titleImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40.0)
            $0.leading.equalToSuperview().inset(20.0)
        }

        mainTitle.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).offset(12.0)
            $0.leading.equalTo(titleImageView.snp.leading)
        }

        subTitle.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(12.0)
            $0.leading.equalTo(mainTitle.snp.leading)
        }

        lineView.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom)
        }
    }

    private func setupRxBindings() {
        rx.deallocated
            .subscribe(onNext: { [weak self] in
                self?.disposeBag = DisposeBag()
            })
            .disposed(by: disposeBag)
    }
}
