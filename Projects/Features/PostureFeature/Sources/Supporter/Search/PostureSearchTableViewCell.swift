import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

public class PostureSearchTableViewCell: BaseTableViewCell {

    public static let identifier: String = "PostureSearchTableViewCell"
    
    public var id: Int = 0

    private var containerView = BaseView()

    private var searchImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = DSKitAsset.Colors.gray50.color
        $0.layer.cornerRadius = 8.0
    }

    private var exerciseNameLabel = MGLabel(font: UIKit.UIFont.Pretendard.bodyMedium,
                                      textColor: .black,
                                      isCenter: false
    )

    private var exercisePartLabel = MGLabel(font: UIFont.Pretendard.bodyMedium,
                                      textColor: DSKitAsset.Colors.gray400.color,
                                      isCenter: false
    )

    public override func layout() {
        super.layout()

        addSubviews([searchImageView, containerView])
        containerView.addSubviews([exerciseNameLabel, exercisePartLabel])

        searchImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.height.equalTo(64.0)
        }

        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(26.0)
            $0.leading.equalTo(searchImageView.snp.trailing).offset(18.0)
            $0.trailing.equalToSuperview()
        }

        exerciseNameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(20.0)
        }

        exercisePartLabel.snp.makeConstraints {
            $0.top.equalTo(exerciseNameLabel.snp.bottom).offset(4.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20.0)
        }
    }
}

public extension PostureSearchTableViewCell {
    func setup(with model: PosePartResponseModel) {
        let text = model.exactPart.joined(separator: ", ")
        let thumbnail = URL(string: model.thumbnail)
        searchImageView.imageFrom(url: thumbnail!)
        exerciseNameLabel.changeText(text: model.name)
        exercisePartLabel.changeText(text: text)
        id = model.id
    }
}
