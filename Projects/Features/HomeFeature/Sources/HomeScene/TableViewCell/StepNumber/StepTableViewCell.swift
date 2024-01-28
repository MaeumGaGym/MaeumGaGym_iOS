import UIKit

import RxSwift
import RxCocoa
import RxFlow

import Then
import SnapKit

import Core
import DSKit

public class StepTableViewCell: UITableViewCell {

    static public var identifier: String = "StepTableViewCell"

    private lazy var stepNumberTitle = UILabel().then {
        $0.numberOfLines = 1
        $0.font = UIFont.Pretendard.titleLarge
        $0.textColor = DSKitAsset.Colors.blue800.color
    }

    public let workTitle = UILabel().then {
        $0.numberOfLines = 1
        $0.font = UIFont.Pretendard.titleSmall
        $0.textColor = DSKitAsset.Colors.gray600.color
        $0.text = "걸음"
    }

    private var disposeBag = DisposeBag()

    public func configure(with step: StepModel) {
        stepNumberTitle.text = "\(formattedLikeCount(step.stepCount))"
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
        self.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubviews([stepNumberTitle, workTitle])

        stepNumberTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(28.0)
        }

        workTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(stepNumberTitle.snp.trailing).offset(12.0)
        }

        rx.deallocated
            .bind { [weak self] in
                self?.disposeBag = DisposeBag()
            }
            .disposed(by: disposeBag)
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
