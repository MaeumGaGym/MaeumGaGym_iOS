import UIKit

import RxSwift
import RxCocoa
import RxFlow

import Then
import SnapKit

import Core
import DSKit

import Domain

import MindGymKit

import HomeFeatureInterface

public class StepTableViewCell: BaseTableViewCell, CollectoionCellID {

    static public var identifier: String = "StepTableViewCell"

    private lazy var stepNumberTitle = MGLabel(font: UIFont.Pretendard.titleLarge,
                                               textColor: DSKitAsset.Colors.blue800.color,
                                               numberOfLineCount: 1
    )

    private let workTitle = MGLabel(text: "걸음",
                                    font: UIFont.Pretendard.titleSmall,
                                    textColor: DSKitAsset.Colors.gray600.color,
                                    numberOfLineCount: 1
    )

    public func configure(with step: StepModel) {
        stepNumberTitle.text = "\(formattedLikeCount(Int(step.stepCount)))"
    }

    public override func commonInit() {
        super.commonInit()

        rx.deallocated
            .bind { [weak self] in
                self?.disposeBag = DisposeBag()
            }
            .disposed(by: disposeBag)
    }

    public override func attribute() {
        super.attribute()

        backgroundColor = DSKitAsset.Colors.gray25.color

    }
    
    public override func layout() {
        super.layout()

        setupCornerRadiusAndBackground()
        contentView.addSubviews([stepNumberTitle, workTitle])

        stepNumberTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(28.0)
        }

        workTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(stepNumberTitle.snp.trailing).offset(12.0)
        }
    }
}

extension StepTableViewCell {
    private func formattedLikeCount(_ count: Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .decimal

        if count < 1000 {
            return "\(count)"
        } else {
            return formatter.string(from: NSNumber(value: count)) ?? ""
        }
    }
}
