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

public class AgreeViewController: BaseViewController<AgreeViewModel>, Stepper {

    public var steps = PublishRelay<Step>()

    private var naviBar = AuthNavigationBarBar()

    private let agreeLabel = MGLabel(
        text: "약관동의",
        font: UIFont.Pretendard.titleLarge
    )

    private let textInformation = MGLabel(
        text: "서비스 이용을 위해 필수 약관동의가 필요해요.",
        font: UIFont.Pretendard.bodyMedium,
        textColor: DSKitAsset.Colors.gray600.color
    )

    private let agreeTermsView = MGAgreeView(
        firstAgreeText: .privacyAgreeText,
        secondAgreeText: .termsAgreeText,
        thirdAgreeText: .ageAgreeText,
        fourthAgreeText: .marketingAgreeText
    )

    private var checkButton = MGCheckButton(text: "확인")

    public override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationController?.isNavigationBarHidden = true
        self.view.frame = self.view.frame.inset(by: UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 0))
    }

    public override func layout() {
        view.addSubviews([naviBar, agreeLabel, textInformation, agreeTermsView, checkButton])
        
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

        agreeTermsView.snp.makeConstraints {
            $0.top.equalTo(textInformation.snp.bottom).offset(40.0)
            $0.leading.equalToSuperview().offset(20.0)
        }

        checkButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.height.equalTo(58.0)
        }
    }

    public override func bindViewModel() {
        super.bindViewModel()
        
        let navButtonTapped = naviBar.leftButtonTap.asDriver(onErrorDriveWith: .never())
        let useCase = DefaultAuthUseCase(authRepository: AuthRepository(networkService: AuthService()))
        
        viewModel = AgreeViewModel(useCase: useCase)

        let input = AgreeViewModel.Input(
            navButtonTapped: navButtonTapped,
            allAgreeButtonTap: agreeTermsView.allAgreeButton.rx.tap.asSignal(),
            firstAgreeButtonTap: agreeTermsView.firstAgreeButton.rx.tap.asSignal(),
            secondAgreeButtonTap: agreeTermsView.secondAgreeButton.rx.tap.asSignal(),
            thirdAgreeButtonTap: agreeTermsView.thirdAgreeButton.rx.tap.asSignal(),
            fourthAgreeButtonTap: agreeTermsView.fourthAgreeButton.rx.tap.asSignal(),
            nextButtonTap: checkButton.rx.tap.asSignal()
        )

        let output = viewModel.transform(input, action: { output in
            output.allAgreeButtonClickedMessage
                .drive(onNext: { [weak self] message in
                    print(message)
                    self?.agreeTermsView.setAllAgreeButtonState(!(self?.agreeTermsView.allAgreeButtonState ?? false))
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
                        self?.agreeTermsView.updateAllAgreeButtonState()
                        MGLogger.verbose(message)
                    })
                    .disposed(by: disposeBag)
            }

            output.firstAgreeButtonClickedMessage
                .drive(onNext: { message in
                    self.agreeTermsView.updateAllAgreeButtonState()
                    _ = self.agreeTermsView.buttonActivationChecked(button: self.checkButton)
                    MGLogger.verbose(message)
                })
                .disposed(by: disposeBag)

            output.secondAgreeButtonClickedMessage
                .drive(onNext: { message in
                    self.agreeTermsView.updateAllAgreeButtonState()
                    _ = self.agreeTermsView.buttonActivationChecked(button: self.checkButton)
                    MGLogger.verbose(message)
                })
                .disposed(by: disposeBag)

            output.thirdAgreeButtonClickedMessage
                .drive(onNext: { message in
                    self.agreeTermsView.updateAllAgreeButtonState()
                    _ = self.agreeTermsView.buttonActivationChecked(button: self.checkButton)
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
}
