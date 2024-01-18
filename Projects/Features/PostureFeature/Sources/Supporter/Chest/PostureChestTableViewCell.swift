import UIKit
import SnapKit
import Then
import DSKit
import Core

public class PostureChestTableViewCell: BaseTableViewCell {

    static let identifier: String = "PostureChestTableViewCell"

    private let postureImageView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 8.0
    }

    private let exerciseNameLabel = UILabel().then {
        $0.textColor = .black
        $0.backgroundColor = .clear
        $0.textAlignment = .left
        $0.font = UIFont.Pretendard.bodyMedium
    }

    public func setup(exerciseImage: UIImage, exerciseNameText: String) {
        self.postureImageView.image = exerciseImage
        self.exerciseNameLabel.text = exerciseNameText

        addViews()
    }

    public override func addViews() {
        [
            postureImageView,
            exerciseNameLabel
        ].forEach { contentView.addSubview($0) }
    }

    public override func layout() {
        super.layout()

        postureImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(12.0)
            $0.bottom.equalToSuperview().inset(12.0)
            $0.width.height.equalTo(64.0)
        }

        exerciseNameLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(34.0)
            $0.leading.equalTo(postureImageView.snp.trailing).offset(18.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(20.0)
        }
    }
}
