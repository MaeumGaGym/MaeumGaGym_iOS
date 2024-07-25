import UIKit

import SnapKit
import Then

import RxSwift
import RxCocoa

import Core
import DSKit
import Domain

public class TargetMainTableViewCell: BaseTableViewCell {

    public var dotButtonTap: ControlEvent<Void> {
        return dotsButton.rx.tap
    }

    public static let identifier: String = "TargetMainTableViewCell"

    private var containerView = UIView().then {
        $0.backgroundColor = .blue50
        $0.layer.cornerRadius = 16.0
    }

    private var targetNameLabel = MGLabel(
        font: UIFont.Pretendard.labelLarge,
        textColor: .black,
        isCenter: false,
        numberOfLineCount: 1
    )

    private var targetPeriodLabel = MGLabel(
        font: UIFont.Pretendard.bodySmall,
        textColor: .gray400,
        numberOfLineCount: 1
    )

    private let dotsButton = MGImageButton(image: .grayDotsActIcon)

    public func setup(with model: TargetContentModel) {
        changeTargetName(text: model.targetTitle)
        changeTargetDate(
            startDate: model.targetStartDate,
            endDate: model.targetEndDate
        )
    }

    override public func layout() {
        super.layout()

        contentView.addSubviews([containerView])
        containerView.addSubviews([targetNameLabel, targetPeriodLabel, dotsButton])

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        targetNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(24.0)
        }

        targetPeriodLabel.snp.makeConstraints {
            $0.top.equalTo(targetNameLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.height.equalTo(18.0)
        }

        dotsButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(29.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.width.height.equalTo(24.0)
        }
    }
}

public extension TargetMainTableViewCell {

    func changeTargetName(text: String) {
        targetNameLabel.changeText(text: text)
    }

    func changeTargetDate(startDate: String, endDate: String) {
        targetPeriodLabel.changeText(text: "\(startDate) ~ \(endDate)")
    }
}
