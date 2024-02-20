import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

public class PostureDetailTitleTableViewCell: BaseTableViewCell{

    static let identifier: String = "PostureDetailTitleTableViewCell"

    private var englishTitle = UILabel().then {
        $0.font = UIFont.Pretendard.titleMedium
        $0.textColor = DSKitAsset.Colors.gray600.color
        $0.textAlignment = .left
    }

    private var koreanTitle = UILabel().then {
        $0.font = UIFont.Pretendard.titleLarge
        $0.textColor = .black
        $0.textAlignment = .left
    }

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
