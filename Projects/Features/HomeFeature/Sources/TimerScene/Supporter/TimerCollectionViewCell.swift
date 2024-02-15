import UIKit

import SnapKit
import Then

import DSKit
import Core

public class TimerCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "TimerCollectionViewCell"

    private var containerView = UIView()

    private var checkImage = UIImageView().then {
        $0.image = DSKitAsset.Assets.yesCheck.image
        $0.isHidden = true
    }

    private var unCheckView = UIView().then {
        $0.layer.cornerRadius = 11.0
        $0.layer.borderColor = DSKitAsset.Colors.gray300.color.cgColor
        $0.layer.borderWidth = 2
        $0.isHidden = true
    }

    private var exerciseNameLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
        $0.backgroundColor = DSKitAsset.Colors.gray50.color
        $0.layer.masksToBounds = true
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.layer.cornerRadius = 50.0
    }

    public func setup(time: Double) {
        exerciseNameLabel.text = setTimerTimeLabelText(from: time)
        layout()
    }

    private func setTimerTimeLabelText(from counter: Double) -> String {
        let hours: String = String(format: "%02d", Int(counter / 3600))
        let minutes: String = String(format: "%02d", Int((counter.truncatingRemainder(dividingBy: 3600)) / 60))
        let seconds: String = String(format: "%02d", Int(counter.truncatingRemainder(dividingBy: 60)))
        if counter / 3600 >= 1 {
            return "\(hours) : \(minutes) : \(seconds)"
        } else if counter / 60 >= 1 {
            return "\(minutes) : \(seconds)"
        } else {
            return "00 : \(seconds)"
        }
    }

    private func layout() {
        addSubviews([exerciseNameLabel, checkImage, unCheckView])
        checkImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(6.0)
            $0.width.height.equalTo(22.0)
        }

        unCheckView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(6.0)
            $0.width.height.equalTo(22.0)
        }

        exerciseNameLabel.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview().inset(10.0)
            $0.width.height.equalTo(100.0)
        }
    }

    public func cellUnClicked() {
        exerciseNameLabel.layer.borderColor = DSKitAsset.Colors.gray50.color.cgColor
        exerciseNameLabel.layer.borderWidth = 2
        exerciseNameLabel.backgroundColor = DSKitAsset.Colors.gray50.color
    }

    public func cellClicked() {
        exerciseNameLabel.layer.borderColor = DSKitAsset.Colors.blue500.color.cgColor
        exerciseNameLabel.layer.borderWidth = 2
        exerciseNameLabel.backgroundColor = .white
    }

    public func cellChoosing() {
        unCheckView.isHidden = true
        checkImage.isHidden = false
    }

    public func cellChoosed() {
        unCheckView.isHidden = false
        checkImage.isHidden = true
    }
}
