import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

open class MGAgreeView: UIView {

    let disposeBag = DisposeBag()
    
    private let decorateLine1 = MGLine()
    public let allAgreeButton = MGAgreeButton(text: .allAgreeText, font: UIFont.Pretendard.labelLarge)
    private let decorateLine2 = MGLine()
    
    public let firstAgreeButton = MGAgreeButton(text: .privacyAgreeText, readMoreType: true)
    public let secondAgreeButton = MGAgreeButton(text: .termsAgreeText, readMoreType: true)
    public let thirdAgreeButton = MGAgreeButton(text: .ageAgreeText)
    public let fourthAgreeButton = MGAgreeButton(text: .marketingAgreeText, chooseType: true)
    
    private var blueColor = DSKitAsset.Colors.blue500.color
    private var grayColor = DSKitAsset.Colors.gray400.color
    
    public init () {
        super.init(frame: .zero)
        setupUI()
    }
    
    public init(firstAgreeText: agreeButtonTextType,
                firstReadMoreType: Bool? = false,
                secondAgreeText: agreeButtonTextType,
                secondReadMoreType: Bool? = false,
                thirdAgreeText: agreeButtonTextType,
                thirdReadMoreType: Bool? = false,
                fourthAgreeText: agreeButtonTextType,
                fourthReadMoreType: Bool? = false
    ) {
        super.init(frame: .zero)
        
        firstAgreeButton.editButtonType(text: firstAgreeText.message, readMoreType: firstReadMoreType)
        secondAgreeButton.editButtonType(text: secondAgreeText.message, readMoreType: secondReadMoreType)
        thirdAgreeButton.editButtonType(text: thirdAgreeText.message, readMoreType: thirdReadMoreType)
        fourthAgreeButton.editButtonType(text: fourthAgreeText.message, readMoreType: fourthReadMoreType)
        
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.snp.makeConstraints {
            $0.width.equalTo(390.0)
            $0.height.equalTo(284.0)
        }
        
        addSubviews([decorateLine1,
                     allAgreeButton,
                     decorateLine2,
                     firstAgreeButton,
                     secondAgreeButton,
                     thirdAgreeButton,
                     fourthAgreeButton])
        
        decorateLine1.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        allAgreeButton.snp.makeConstraints {
            $0.top.equalTo(decorateLine1.snp.bottom).offset(12.0)
            $0.centerX.equalToSuperview()
        }
        
        decorateLine2.snp.makeConstraints {
            $0.top.equalTo(allAgreeButton.snp.bottom).offset(12.0)
            $0.centerX.equalToSuperview()
        }
        
        firstAgreeButton.snp.makeConstraints {
            $0.top.equalTo(decorateLine2.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
        }
        
        secondAgreeButton.snp.makeConstraints {
            $0.top.equalTo(firstAgreeButton.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
        }
        
        thirdAgreeButton.snp.makeConstraints {
            $0.top.equalTo(secondAgreeButton.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
        }
        
        fourthAgreeButton.snp.makeConstraints {
            $0.top.equalTo(thirdAgreeButton.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
        }
    }
    
    public var allAgreeButtonState: Bool {
        return firstAgreeButton.checked &&
               secondAgreeButton.checked &&
               thirdAgreeButton.checked &&
               fourthAgreeButton.checked
    }

    public func setAllAgreeButtonState(_ isEnabled: Bool) {
        allAgreeButton.checked = isEnabled
        if isEnabled {
            firstAgreeButton.buttonYesChecked()
            secondAgreeButton.buttonYesChecked()
            thirdAgreeButton.buttonYesChecked()
            fourthAgreeButton.buttonYesChecked()
            updateAllAgreeButtonState()
        } else {
            firstAgreeButton.buttonNoChecked()
            secondAgreeButton.buttonNoChecked()
            thirdAgreeButton.buttonNoChecked()
            fourthAgreeButton.buttonNoChecked()
            updateAllAgreeButtonState()
        }
    }

    public func updateAllAgreeButtonState() {
        if allAgreeButtonState == true {
            allAgreeButton.buttonYesChecked()
        } else {
            allAgreeButton.buttonNoChecked()
        }
    }
    
    public func buttonActivationChecked(button: MGCheckButton) -> Bool {
        let shouldActivateButton = firstAgreeButton.checked &&
                                   secondAgreeButton.checked &&
                                   thirdAgreeButton.checked &&
                                   !fourthAgreeButton.checked

        button.isEnabled = shouldActivateButton
        button.backgroundColor = shouldActivateButton ? blueColor : grayColor
        button.textLabel.textColor = shouldActivateButton ? .white : DSKitAsset.Colors.gray200.color

        return shouldActivateButton
    }
}
