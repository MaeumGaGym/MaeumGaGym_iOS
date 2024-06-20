import UIKit

import RxSwift
import RxCocoa
import RxFlow

import SnapKit
import Then

import Core
import DSKit
import MGLogger

import AuthFeatureInterface
import SafariServices

public class AgreeViewController: BaseViewController<AgreeViewModel>, Stepper, UIGestureRecognizerDelegate {

    private var naviBar = AuthNavigationBarBar()

    private let containerView = BaseView()

    private let agreeLabel = MGLabel(
        text: "약관동의",
        font: UIFont.Pretendard.titleLarge
    )

    private let textInformation = MGLabel(
        text: "서비스 이용을 위해 필수 약관동의가 필요해요.",
        font: UIFont.Pretendard.bodyMedium,
        textColor: DSKitAsset.Colors.gray600.color
    )

    private let decorateLine1 = MGLine()
    private let allAgreeButton = MGAgreeButton(type: .allAgreeText)
    private let decorateLine2 = MGLine()
    private let firstAgreeButton = MGAgreeButton(type: .privacyAgreeText)
    private let firstSeemoreButton = AuthSeemoreButton()
    private let secondAgreeButton = MGAgreeButton(type: .termsAgreeText)
    private let secondSeemoreButton = AuthSeemoreButton()
    private let thirdAgreeButton = MGAgreeButton(type: .ageAgreeText)
    private let fourthAgreeButton = MGAgreeButton(type: .marketingAgreeText, chooseType: true)

    private var checkButton = MGCheckButton(text: "확인").then {
        $0.isEnabled = false
    }

    public override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationController?.isNavigationBarHidden = true
        self.view.frame = self.view.frame.inset(by: UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 0))
    }

    public override func attribute() {
        super.attribute()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    public override func layout() {
        view.addSubviews([naviBar, agreeLabel, textInformation, containerView, checkButton])

        naviBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        agreeLabel.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(125.0)
        }

        textInformation.snp.makeConstraints {
            $0.top.equalTo(agreeLabel.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(287.0)
        }

        containerView.snp.makeConstraints {
            $0.top.equalTo(textInformation.snp.bottom).offset(40.0)
            $0.height.equalTo(284.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        checkButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.height.equalTo(58.0)
        }

        containerView.addSubviews([decorateLine1,
                     allAgreeButton,
                     decorateLine2,
                     firstAgreeButton,
                     secondAgreeButton,
                     thirdAgreeButton,
                     fourthAgreeButton])
        firstAgreeButton.addSubview(firstSeemoreButton)
        secondAgreeButton.addSubview(secondSeemoreButton)

        decorateLine1.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        allAgreeButton.snp.makeConstraints {
            $0.top.equalTo(decorateLine1.snp.bottom).offset(12.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44.0)
        }

        decorateLine2.snp.makeConstraints {
            $0.top.equalTo(allAgreeButton.snp.bottom).offset(12.0)
            $0.centerX.equalToSuperview()
        }

        firstAgreeButton.snp.makeConstraints {
            $0.top.equalTo(decorateLine2.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44.0)
        }
        
        firstSeemoreButton.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(64.0)
        }

        secondAgreeButton.snp.makeConstraints {
            $0.top.equalTo(firstAgreeButton.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44.0)
        }
        
        secondSeemoreButton.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(64.0)
        }

        thirdAgreeButton.snp.makeConstraints {
            $0.top.equalTo(secondAgreeButton.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44.0)
        }

        fourthAgreeButton.snp.makeConstraints {
            $0.top.equalTo(thirdAgreeButton.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44.0)
        }
    }

    public override func bindViewModel() {
        super.bindViewModel()

        let navButtonTapped = naviBar.leftButtonTap.asDriver(onErrorDriveWith: .never())

        let input = AgreeViewModel.Input(
            navButtonTapped: navButtonTapped,
            allAgreeButtonTap: allAgreeButton.rx.tap.asSignal(),
            firstAgreeButtonTap: firstAgreeButton.rx.tap.asSignal(),
            firstSeeMoreButtonTap: firstSeemoreButton.rx.tap.asDriver(),
            secondAgreeButtonTap: secondAgreeButton.rx.tap.asSignal(),
            secondSeeMoreButtonTap: secondSeemoreButton.rx.tap.asSingle(),
            thirdAgreeButtonTap: thirdAgreeButton.rx.tap.asSignal(),
            fourthAgreeButtonTap: fourthAgreeButton.rx.tap.asSignal(),
            nextButtonTap: checkButton.rx.tap.asSignal()
        )

        _ = viewModel.transform(input, action: { output in
            output.allAgreeButtonClickedMessage
                .withUnretained(self)
                .subscribe(onNext: { owner, message in
                    owner.setAllAgreeButtonState(!(owner.allAgreeButtonState))
                    _ = owner.buttonActivationChecked(button: owner.checkButton)
                })
                .disposed(by: disposeBag)

            let agreeButtons = [
                output.firstAgreeButtonClickedMessage,
                output.secondAgreeButtonClickedMessage,
                output.thirdAgreeButtonClickedMessage,
                output.fourthAgreeButtonClickedMessage
            ]

            agreeButtons.forEach { buttonOutput in
                buttonOutput
                    .withUnretained(self)
                    .subscribe(onNext: { owner, message in
                        owner.updateAllAgreeButtonState()
                        MGLogger.verbose(message)

                    })
                    .disposed(by: disposeBag)
            }

            output.firstAgreeButtonClickedMessage
                .withUnretained(self)
                .subscribe(onNext: { owner, message in
                    owner.updateAllAgreeButtonState()
                    _ = owner.buttonActivationChecked(button: owner.checkButton)
                    MGLogger.verbose(message)

                })
                .disposed(by: disposeBag)

            output.secondAgreeButtonClickedMessage
                .withUnretained(self)
                .subscribe(onNext: { owner, message in
                    owner.updateAllAgreeButtonState()
                    _ = owner.buttonActivationChecked(button: owner.checkButton)
                    MGLogger.verbose(message)

                })
                .disposed(by: disposeBag)

            output.thirdAgreeButtonClickedMessage
                .withUnretained(self)
                .subscribe(onNext: { owner, message in
                    owner.updateAllAgreeButtonState()
                    _ = owner.buttonActivationChecked(button: owner.checkButton)
                    MGLogger.verbose(message)

                })
                .disposed(by: disposeBag)

            output.fourthAgreeButtonClickedMessage
                .withUnretained(self)
                .subscribe(onNext: { owner, message in
                    MGLogger.verbose(message)

                })
                .disposed(by: disposeBag)

            output.nextButtonClicked
                .drive(onNext: { message in
                    AuthStepper.shared.steps.accept(MGStep.authNickNameIsRequired)
                    MGLogger.verbose(message)
                })
                .disposed(by: disposeBag)
        })
    }
    
    public override func bindActions() {
        super.bindActions()
        
        firstSeemoreButton.rx.tap
            .subscribe(onNext: { _ in
                let url = NSURL(string: "https://info-dsm.notion.site/e9d45a0490674b81a419bbc4cbdd5a9d?pvs=4")
                
                let safariView: SFSafariViewController = SFSafariViewController(url: url! as URL)
                self.present(safariView, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        secondSeemoreButton.rx.tap
            .subscribe(onNext: {
                let url = NSURL(string: "https://info-dsm.notion.site/2a0474e87f754fbe8f53d58f2003ccb2?pvs=4")
                
                let safariView: SFSafariViewController = SFSafariViewController(url: url! as URL)
                self.present(safariView, animated: true, completion: nil)
            }).disposed(by: disposeBag)
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
                                    !fourthAgreeButton.checked || firstAgreeButton.checked &&
        secondAgreeButton.checked &&
        thirdAgreeButton.checked &&
        fourthAgreeButton.checked
        button.isEnabled = shouldActivateButton
        button.backgroundColor = shouldActivateButton ? DSKitAsset.Colors.blue500.color : DSKitAsset.Colors.gray400.color
        button.textLabel.textColor = shouldActivateButton ? .white : DSKitAsset.Colors.gray200.color

        return shouldActivateButton
    }
}
