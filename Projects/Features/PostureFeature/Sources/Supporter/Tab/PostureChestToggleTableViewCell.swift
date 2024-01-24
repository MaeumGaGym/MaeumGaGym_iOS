import UIKit
import SnapKit
import Then
import DSKit
import RxSwift
import Core

public class PostureChestToggleTableViewCell: BaseTableViewCell {

    static let identifier: String = "PostureChestToggleTableViewCell"
    
    private var firstButtonCliked: Bool = false
    private var secondButtonCliked: Bool = false

    private var firstButton = MGToggleButton(type: .bareBody)
    private var secondButton = MGToggleButton(type: .marchine)

    public func setup(firstType: ToggleButtonType, secondType: ToggleButtonType) {
        self.firstButton = MGToggleButton(type: firstType)
        self.secondButton = MGToggleButton(type: secondType)

        bind(firstType: firstType, secondType: secondType)
        addViews()
    }

    public override func addViews() {
        super.addViews()
        [
            firstButton,
            secondButton
        ].forEach { contentView.addSubview($0) }
        
        layout()
    }

    public override func layout() {
        super.layout()
        firstButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12.0)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }

        secondButton.snp.makeConstraints {
            $0.leading.equalTo(firstButton.snp.trailing).offset(8.0)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }
    }

    private func bind(firstType: ToggleButtonType, secondType: ToggleButtonType) {
        firstButton.rx.tap
            .subscribe(onNext: {
                switch self.firstButtonCliked {
                case false:
                    self.firstButton.buttonYesChecked(type: firstType)
                    self.secondButton.buttonNoChecked(type: secondType)
                    self.firstButtonCliked = true
                    self.secondButtonCliked = false
                case true:
                    self.firstButton.buttonNoChecked(type: firstType)
                    self.firstButtonCliked = false
                }
            }).disposed(by: disposeBag)

        secondButton.rx.tap
            .subscribe(onNext: {
                switch self.secondButtonCliked {
                case false:
                    self.secondButton.buttonYesChecked(type: secondType)
                    self.firstButton.buttonNoChecked(type: firstType)
                    self.secondButtonCliked = true
                    self.firstButtonCliked = false
                case true:
                    self.secondButton.buttonNoChecked(type: secondType)
                    self.secondButtonCliked = false
                }
            }).disposed(by: disposeBag)
    }
}
