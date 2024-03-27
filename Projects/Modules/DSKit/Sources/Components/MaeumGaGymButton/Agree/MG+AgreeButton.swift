import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core

open class MGAgreeButton: BaseButton {
    
    public var checked: Bool = false

    private var iconImageView = UIImageView().then {
        $0.image = DSKitAsset.Assets.noCheckActIcon.image
    }

    private var textLabel = MGLabel(numberOfLineCount: 1)

    private let chooseLabel = MGLabel(text: "(선택)",
                                      font: UIFont.Pretendard.bodyMedium,
                                      textColor: DSKitAsset.Colors.gray400.color,
                                      isCenter: false,
                                      numberOfLineCount: 1
    ).then {
        $0.isHidden = true
    }

    public init (
        type: agreeButtonTextType,
        chooseType: Bool? = false
    ) {
        super.init(frame: .zero)

        setup(textType: type, chooseType: chooseType)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layout() {
        super.layout()

        self.addSubviews([iconImageView, textLabel, chooseLabel])

        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(28.0)
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        textLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12.0)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20.0)
        }

        chooseLabel.snp.makeConstraints {
            $0.height.equalTo(20.0)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(textLabel.snp.trailing).offset(5.0)
        }
    }

    public func buttonYesChecked() {
        checked = true
        iconImageView.image = DSKitAsset.Assets.yesCheckActIcon.image
    }

    public func buttonNoChecked() {
        checked = false
        iconImageView.image = DSKitAsset.Assets.noCheckActIcon.image
    }
    
    public override func buttonAction() {
        self.rx.tap.subscribe(onNext: { [self] in
            checked ? buttonNoChecked() : buttonYesChecked()
        }).disposed(by: disposeBag)
    }
}

private extension MGAgreeButton {
    func setup(textType: agreeButtonTextType,
               chooseType: Bool? = false
    ) {
        textLabel.changeText(text: textType.message)
        textLabel.changeFont(font: textType.font)
        if chooseType == true {
            chooseLabel.isHidden = false
        }
    }
}
