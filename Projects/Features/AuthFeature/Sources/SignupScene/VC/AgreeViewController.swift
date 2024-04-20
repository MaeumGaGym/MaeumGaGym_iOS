import UIKit

import RxSwift
import RxCocoa
import RxFlow

import SnapKit
import Then

import Core
import DSKit
import Data

import Domain
import MGLogger
import MGNetworks

public class AgreeViewController: BaseViewController<AgreeViewModel>, Stepper, UIGestureRecognizerDelegate {

    public var steps = PublishRelay<Step>()

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
    private let secondAgreeButton = MGAgreeButton(type: .termsAgreeText)
    private let thirdAgreeButton = MGAgreeButton(type: .ageAgreeText)
    private let fourthAgreeButton = MGAgreeButton(type: .marketingAgreeText, chooseType: true)

    private var checkButton = MGCheckButton(text: "확인")

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

        secondAgreeButton.snp.makeConstraints {
            $0.top.equalTo(firstAgreeButton.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44.0)
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
        let useCase = DefaultAuthUseCase(authRepository: AuthRepository(networkService: AuthService()))

        viewModel = AgreeViewModel(useCase: useCase)

        let input = AgreeViewModel.Input(
            navButtonTapped: navButtonTapped,
            allAgreeButtonTap: allAgreeButton.rx.tap.asSignal(),
            firstAgreeButtonTap: firstAgreeButton.rx.tap.asSignal(),
            secondAgreeButtonTap: secondAgreeButton.rx.tap.asSignal(),
            thirdAgreeButtonTap: thirdAgreeButton.rx.tap.asSignal(),
            fourthAgreeButtonTap: fourthAgreeButton.rx.tap.asSignal(),
            nextButtonTap: checkButton.rx.tap.asSignal()
        )

        let output = viewModel.transform(input, action: { output in
            output.allAgreeButtonClickedMessage
                .drive(onNext: { [weak self] message in
                    print(message)
                    self?.setAllAgreeButtonState(!(self?.allAgreeButtonState ?? false))
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
                    .drive(onNext: { [weak self] message in
                        self?.updateAllAgreeButtonState()
                        MGLogger.verbose(message)
                    })
                    .disposed(by: disposeBag)
            }

            output.firstAgreeButtonClickedMessage
                .drive(onNext: { message in
                    self.updateAllAgreeButtonState()
                    _ = self.buttonActivationChecked(button: self.checkButton)
                    MGLogger.verbose(message)
                })
                .disposed(by: disposeBag)

            output.secondAgreeButtonClickedMessage
                .drive(onNext: { message in
                    self.updateAllAgreeButtonState()
                    _ = self.buttonActivationChecked(button: self.checkButton)
                    MGLogger.verbose(message)
                })
                .disposed(by: disposeBag)

            output.thirdAgreeButtonClickedMessage
                .drive(onNext: { message in
                    self.updateAllAgreeButtonState()
                    _ = self.buttonActivationChecked(button: self.checkButton)
                    MGLogger.verbose(message)
                })
                .disposed(by: disposeBag)

            output.fourthAgreeButtonClickedMessage
                .drive(onNext: { message in
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
        button.backgroundColor = shouldActivateButton ? AuthResourcesService.Colors.blue500 : AuthResourcesService.Colors.gray400
        button.textLabel.textColor = shouldActivateButton ? .white : AuthResourcesService.Colors.gray200

        return shouldActivateButton
    }
}
