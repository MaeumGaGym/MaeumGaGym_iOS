import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

import MGNetworks

public class PostureDetailTitleTableViewCell: BaseTableViewCell{

    static let identifier: String = PostureResourcesService.Identifier.postureDetailTitleTableViewCell

    private var englishTitle = MGLabel(font: UIFont.Pretendard.titleMedium,
                                      textColor: DSKitAsset.Colors.gray600.color,
                                      isCenter: false
    )

    private var koreanTitle = MGLabel(font: UIFont.Pretendard.titleLarge,
                                      textColor: .black,
                                      isCenter: false
    )

    public override func layout() {
        contentView.addSubviews([englishTitle, koreanTitle])

        englishTitle.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(32.0)
            $0.top.equalToSuperview().offset(32.0)
            $0.trailing.leading.equalToSuperview().inset(20.0)
        }

        koreanTitle.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(48.0)
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(20.0)
        }
    }
}

public extension PostureDetailTitleTableViewCell {
    func setup(with model: PostureDetailTitleTextModel) {
        englishTitle.text = model.englishName
        koreanTitle.text = model.koreanName
    }
}
    

