import UIKit
import SnapKit
import Then
import Core
import RxFlow
import RxCocoa
import RxSwift
import DSKit
import MGLogger

public class AgreeViewController: BaseViewController<AgreeViewModel> {

    public var steps = PublishRelay<Step>()

    public var initialStep: Step {
        AppStep.homeIsRequired
    }

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

    public override func layout() {
        self.view.addSubviews([agreeLabel, textInformation, agreeTermsView, checkButton])

        agreeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(76.0)
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

    public override func bindActions() {
        checkButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(
                    NicknameViewController(NicknameViewModel()),
                    animated: false)
            })
    }

    public override func bindViewModel() {
        super.bindViewModel()

        let input = AgreeViewModel.Input(
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
                .drive(onNext: { message in// 네비게이션 컨트롤러 확인
                    MGLogger.verbose(message)
                })
                .disposed(by: disposeBag)
        })
    }
}
