import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core

open class MGAgreeButton: BaseButton {
        
    public var checked: Bool = false
    
    public var iconImageView = UIImageView().then {
        $0.image = DSKitAsset.Assets.noCheck.image
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
    
    private let readMore = MGButton(
        titleText: "자세히 보기",
        font: UIFont.Pretendard.labelSmall,
        textColor: DSKitAsset.Colors.gray300.color
    ).then {
        $0.isHidden = false
    }

    private let readMoreLine = MGLine(lineColor: DSKitAsset.Colors.gray300.color,
                                              lineWidth: 64.0,
                                              lineHeight: 1.0
    )

    public init (
        text: agreeButtonTextType,
        font: UIFont? = UIFont.Pretendard.bodyMedium,
        type: Int? = 1,
        readMoreType: Bool? = false,
        chooseType: Bool? = false
    ) {
        super.init(frame: .zero)
        
        setupUI(textType: text,
                font: font,
                type: type,
                readMoreType: readMoreType,
                chooseType: chooseType)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layout() {
        super.layout()
        
        self.addSubviews([iconImageView, textLabel, chooseLabel, readMoreLine, readMore])
        
        self.snp.makeConstraints {
            $0.width.equalTo(390.0)
            $0.height.equalTo(44.0)
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(28.0)
            $0.leading.equalToSuperview().offset(0.0)
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
        
        readMoreLine.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(0.0)
            $0.bottom.equalToSuperview().offset(-13.0)
        }
        
        readMore.snp.makeConstraints {
            $0.width.equalTo(64.0)
            $0.height.equalToSuperview()
            $0.trailing.equalToSuperview().offset(0.0)
            $0.top.equalToSuperview().offset(0.0)
        }
    }
    
    open override func buttonAction() {
        super.buttonAction()
        buttonTapped()
    }
    
    public func buttonYesChecked() {
        checked = true
        iconImageView.image = DSKitAsset.Assets.yesCheck.image
    }
    
    public func buttonNoChecked() {
        checked = false
        iconImageView.image = DSKitAsset.Assets.noCheck.image
    }
    
    public func editButtonType(text: String, readMoreType: Bool? = false) {
        self.textLabel.text = text
        
        readMore.isHidden = !(readMoreType ?? true)
        readMoreLine.isHidden = !(readMoreType ?? true)
    }
}

private extension MGAgreeButton {
    func setupUI(textType: agreeButtonTextType,
                         font: UIFont?,
                         type: Int?,
                         readMoreType: Bool?,
                         chooseType: Bool?
    ) {
        self.textLabel.text = textType.message
        self.textLabel.font = font
        
        setOptionalViewVisibility(shouldShow: chooseType ?? true)

        if (type != nil) != false {
            chooseLabel.isHidden = false
        }
    }
    
    func buttonTapped() {
        rx.tap
            .subscribe(onNext: { [self] in
                checked ? buttonNoChecked() : buttonYesChecked()
            }).disposed(by: disposeBag)
        
        readMore.rx.tap
            .subscribe(onNext: {
                print("자세히 보기 클릭 됨")
            }).disposed(by: disposeBag)
    }
    
    func setOptionalViewVisibility(shouldShow: Bool) {
        chooseLabel.isHidden = !shouldShow
        readMore.isHidden = !shouldShow
        readMoreLine.isHidden = !shouldShow
    }
}
