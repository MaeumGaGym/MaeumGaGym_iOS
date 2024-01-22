import UIKit
import SnapKit
import Then
import DSKit

public class PostureDetailTagTableViewCell: UITableViewCell {

    static let identifier: String = "PostureDetailTagTableViewCell"

    private var exerciseName = MGTagLabel(text: "맨몸")
    private var exercisePart = MGTagLabel(text: "가슴")

    public func setup(exerciseNameText: String, exercisePartText: String) {
        self.exerciseName.updateData(text: "맨몸")
        self.exercisePart.updateData(text: "가슴")

        addViews()
        setupViews()
    }

    private func addViews() {
        [
            exerciseName,
            exercisePart
        ].forEach { contentView.addSubview($0) }
    }

    private func setupViews() {
        exerciseName.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(32.0)
        }

        exercisePart.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalTo(exerciseName.snp.trailing).offset(10.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }
    }
}
