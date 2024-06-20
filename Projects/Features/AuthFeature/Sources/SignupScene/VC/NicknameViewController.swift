import UIKit

import RxSwift
import RxCocoa
import RxFlow

import SnapKit
import Then

import Core
import DSKit

import Domain
import MGLogger

import AuthFeatureInterface

public class NicknameViewController: BaseViewController<NicknameViewModel>, Stepper {

    private lazy var naviBar = AuthNavigationBarBar()

    private var bottomConstraint: Constraint?

    private let nicknameTitle = MGLabel(text: "닉네임",
                                        font: UIFont.Pretendard.titleLarge,
                                        isCenter: false)

    private let textInformation = MGLabel(text: "자신만의 닉네임을 입력해 주세요.",
                                          font: UIFont.Pretendard.bodyMedium,
                                          textColor: DSKitAsset.Colors.gray600.color,
                                          isCenter: false)

    private let nicknameTF = MGTextField(placeholder: "닉네임").then {
        $0.clearButtonMode = .whileEditing
    }

    public var nextButton = MGCheckButton(text: "회원가입").then {
        $0.isEnabled = true
    }

    public override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationController?.isNavigationBarHidden = true
        self.view.frame = self.view.frame.inset(by: UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 0))
    }

    public override func attribute() {
        super.attribute()

        keyboardBind()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    public override func layout() {
        view.addSubviews([naviBar,
                          nicknameTitle,
                          textInformation,
                          nicknameTF,
                          nextButton])

        naviBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        nicknameTitle.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(165.0)
        }

        textInformation.snp.makeConstraints {
            $0.top.equalTo(nicknameTitle.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(287.0)
        }

        nicknameTF.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.0)
            $0.top.equalTo(textInformation.snp.bottom).offset(50.0)
            $0.height.equalTo(40.0)
            $0.width.equalTo(390.0)
        }

        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.height.equalTo(58.0)
        }
    }

    public override func bindViewModel() {

        let navButtonTapped = naviBar.leftButtonTap.asDriver(onErrorDriveWith: .never())
        let nextButtonTapped = nextButton.rx.tap
            .withLatestFrom(nicknameTF.rx.text)
            .asDriver(onErrorDriveWith: .never())

        let input = NicknameViewModel.Input(navButtonTap: navButtonTapped, nextButtonTap: nextButtonTapped)

        _ = viewModel.transform(input, action: { output in
            output.navButtonTap.drive(onNext: { _ in
                AuthStepper.shared.steps.accept(MGStep.authBack)
            }).disposed(by: disposeBag)
    
            output.nicknameState
                .withUnretained(self)
                .subscribe(onNext: { owner, state in
                    owner.nicknameTF.errorMessage = state ? "" : "이미 사용중인 닉네임이에요."
                    owner.nicknameTF.showError = !state
                }).disposed(by: disposeBag)
        })
    }
    
    public override func bindActions() {
        nicknameTF.rx.controlEvent([.editingDidBegin])
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.nicknameTFTapped()
            })
            .disposed(by: disposeBag)
    }

    private func nicknameTFTapped() {
        nicknameTF.rx.text
            .map { ($0?.count ?? 0) >= 2 && ($0?.count ?? 0) <= 10 ? true : false }
            .subscribe(
                onNext: { [weak self] state in
                    MGLogger.debug(state)
                    switch state {
                    case true:
                        self?.nextButton.isEnabled = state
                        self?.nicknameTF.showError = false
                        self?.nextButton.backgroundColor = DSKitAsset.Colors.blue500.color
                        self?.nextButton.changeTextColor(textColor: .white)
                    case false:
                        self?.nicknameTF.errorMessage = "닉네임은 2~10자로 공백을 포함할 수 없어요."
                        self?.nicknameTF.showError = true
                        self?.nextButton.isEnabled = state
                        self?.nextButton.backgroundColor = DSKitAsset.Colors.gray400.color
                        self?.nextButton.changeTextColor(textColor: DSKitAsset.Colors.gray200.color)
                    }
                }).disposed(by: disposeBag)
        
        nicknameTF.rx.text.orEmpty
                    .map { $0.replacingOccurrences(of: " ", with: "") }
                    .bind(to: nicknameTF.rx.text)
                    .disposed(by: disposeBag)
    }

    func animateButtonWithKeyboard(notification: NSNotification, show: Bool) {
        guard let keyboardSize = (notification.userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey
        ] as? NSValue)?.cgRectValue,
              let keyboardAnimationDuration = notification.userInfo?[
                UIResponder.keyboardAnimationDurationUserInfoKey
              ] as? TimeInterval else {
            return
        }

        let offset = show ? -keyboardSize.height : -20.0
        bottomConstraint?.update(offset: offset)

        UIView.animate(withDuration: keyboardAnimationDuration) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        animateButtonWithKeyboard(notification: notification, show: true)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        animateButtonWithKeyboard(notification: notification, show: false)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    private func keyboardBind() {
        let keyboardWillShowObservable = NotificationCenter.default.rx.notification(
            UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 48 }

        let keyboardWillHideObservable = NotificationCenter.default.rx.notification(
            UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(48) }

        Observable.merge(keyboardWillShowObservable)
            .withUnretained(self)
            .subscribe(onNext: { owner, height in

                owner.nextButton.snp.remakeConstraints {
                    owner.bottomConstraint = $0.bottom.equalToSuperview().offset(-height).constraint
                    $0.width.equalToSuperview()
                    $0.height.equalTo(58.0)
                }
                owner.nextButton.layer.cornerRadius = 0
                UIView.animate(withDuration: 0.3) {
                    owner.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)

        Observable.merge(keyboardWillHideObservable)
            .withUnretained(self)
            .subscribe(onNext: { owner, height in
                owner.nextButton.snp.remakeConstraints {
                    owner.bottomConstraint?.update(offset: -height + 112.0)
                    $0.leading.equalToSuperview().offset(20.0)
                    $0.trailing.equalToSuperview().offset(-20.0)
                    $0.width.equalTo(390.0)
                    $0.height.equalTo(58.0)
                    $0.bottom.equalTo((owner.view.safeAreaLayoutGuide))
                }
                owner.nextButton.layer.cornerRadius = 8.0
                UIView.animate(withDuration: 0.3) {
                    owner.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
    }
}
