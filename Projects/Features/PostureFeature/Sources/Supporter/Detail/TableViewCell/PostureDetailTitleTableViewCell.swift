import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

import MGNetworks

public class PostureDetailTitleTableViewCell: BaseTableViewCell {

    static let identifier: String = PostureResourcesService.Identifier.postureDetailTitleTableViewCell

    private var containerView = BaseView()

    private var englishTitle = MGLabel(font: UIFont.Pretendard.titleMedium,
                                      textColor: DSKitAsset.Colors.gray600.color,
                                      isCenter: false
    )

    private var koreanTitle = MGLabel(font: UIFont.Pretendard.titleLarge,
                                      textColor: .black,
                                      isCenter: false
    )

    public override func layout() {
        super.layout()

        contentView.addSubviews([containerView])
        containerView.addSubviews([englishTitle, koreanTitle])
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview()
        }

        englishTitle.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(32.0)
        }

        koreanTitle.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.0)
        }
    }
}

public extension PostureDetailTitleTableViewCell {
    func setup(with model: PostureDetailTitleTextModel) {
        englishTitle.changeText(text: model.englishName)
        koreanTitle.changeText(text: model.koreanName)
    }
}
