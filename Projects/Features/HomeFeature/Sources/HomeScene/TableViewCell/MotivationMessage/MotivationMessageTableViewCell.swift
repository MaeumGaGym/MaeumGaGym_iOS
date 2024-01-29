import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core
import DSKit

public class MotivationMessageTableViewCell: BaseTableViewCell {

    static public var identifier: String = "MotivationMessageTableViewCell"

    private let messageLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.Pretendard.titleMedium
        $0.textColor = DSKitAsset.Colors.blue500.color
    }

    private let authorLabel = UILabel().then {
        $0.font = UIFont.Pretendard.labelMedium
        $0.textColor = DSKitAsset.Colors.gray500.color
    }

    public func configure(with message: MotivationMessageModel) {
        messageLabel.text = "\"\(message.text)\""
        authorLabel.text = "\(message.author)"
    }
    
    public override func attribute() {
        super.attribute()
        
        backgroundColor = DSKitAsset.Colors.gray25.color
        setupRxBindings()
    }
    
    public override func layout() {
        super.layout()
        
        addSubviews([messageLabel, authorLabel])
        messageLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.lessThanOrEqualToSuperview().inset(8).priority(.high)
        }

        authorLabel.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(8)
            $0.leading.equalTo(messageLabel.snp.leading)
            $0.bottom.equalToSuperview()
        }

    }

    private func setupRxBindings() {
        rx.deallocated
            .subscribe(onNext: { [weak self] in
                self?.disposeBag = DisposeBag()
            })
            .disposed(by: disposeBag)
    }
}
