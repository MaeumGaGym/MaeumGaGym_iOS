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

    static public var identifier: String = SelfCareResourcesService.identifier.selfCareIntroductTableViewCell

    private let titleImageView = MGProfileView(
        profileImage: MGProfileImage(type: .custom,
                                     customImage: SelfCareResourcesService.Assets.selfCareMain),
        profileType: .smallProfile
    )

    private let mainTitle = MGLabel(font: UIFont.Pretendard.titleLarge)
    
    private let subTitle = MGLabel(font: UIFont.Pretendard.bodyMedium,
                                   textColor: DSKitAsset.Colors.gray600.color,
                                   numberOfLineCount: 2
    )

    public func configure(with message: SelfCareIntroductModel) {
        titleImageView.configureImage(with: MGProfileImage(type: .custom,
                                                       customImage: message.image))
        mainTitle.text = "\"\(message.mainText)\""
        subTitle.text = "\(message.subText)"
    }

    public override func attribute() {
        super.attribute()

        backgroundColor = .white
        setupRxBindings()
    }

    public override func layout() {
        super.layout()

        addSubviews([titleImageView, mainTitle, subTitle])
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
    }

    private func setupRxBindings() {
        rx.deallocated
            .subscribe(onNext: { [weak self] in
                self?.disposeBag = DisposeBag()
            })
            .disposed(by: disposeBag)
    }
}
