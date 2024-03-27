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

import AuthFeatureInterface

public class NicknameViewController: BaseViewController<NicknameViewModel>, Stepper {

    public var steps = PublishRelay<Step>()

    private lazy var naviBar = AuthNavigationBarBar()

    private var bottomConstraint: Constraint?

    private let nicknameTitle = MGLabel(text: "닉네임",
                                        font: UIFont.Pretendard.titleLarge,
                                        isCenter: false)

    private let textInformation = MGLabel(text: "자신만의 닉네임을 입력해 주세요.",
                                          font: UIFont.Pretendard.bodyMedium,
                                          textColor: DSKitAsset.Colors.gray600.color,
                                          isCenter: false)

    private let nicknameTF = MGTextField(placeholder: "닉네임")

    private let cancelButton = MGImageButton(image: DSKitAsset.Assets.whiteCancel.image).then {
        $0.isEnabled = true
    }

    private var checkButton = MGCheckButton(text: "회원가입")

    public override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationController?.isNavigationBarHidden = true
        self.view.frame = self.view.frame.inset(by: UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 0))
    }

    public override func attribute() {
        super.attribute()

        cancelButtonTap()
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
                          cancelButton,
                          checkButton])

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

        cancelButton.snp.makeConstraints {
            $0.centerY.equalTo(nicknameTF)
            $0.trailing.equalTo(nicknameTF).offset(-10)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        checkButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.height.equalTo(58.0)
        }
    }
    
    public override func bindViewModel() {
        let useCase = DefaultAuthUseCase(authRepository: AuthRepository(networkService: AuthService()))
        viewModel = NicknameViewModel(useCase: useCase)

        let navButtonTapped = naviBar.leftButtonTap.asDriver(onErrorDriveWith: .never())
        let nextButtonTapped = checkButton.rx.tap.asDriver(onErrorDriveWith: .never())

        let input = NicknameViewModel.Input(navButtonTap: navButtonTapped, nextButtonTap: nextButtonTapped)
        
        let output = viewModel.transform(input, action: { output in
            output.nextButtonTap.drive(onNext: { _ in
                useCase.changeNickname(nickname: self.nicknameTF.text ?? "")
                useCase.nextButtonTap()
            }).disposed(by: disposeBag)

            output.navButtonTap.drive(onNext: { _ in
                AuthStepper.shared.steps.accept(MGStep.authBack)
            }).disposed(by: disposeBag)
        })
    }
    
    public override func bindActions() {
        nicknameTF.rx.text
            .map { ($0?.count ?? 0) >= 2 && ($0?.count ?? 0) <= 10 ? true : false }
            .subscribe(
                onNext: { [weak self] state in
                    MGLogger.debug(state)
                    switch state {
                    case true:
                        self?.checkButton.isEnabled = state
                        self?.checkButton.backgroundColor = AuthResourcesService.Colors.blue500
                    case false:
                        self?.checkButton.isEnabled = state
                        self?.checkButton.backgroundColor = AuthResourcesService.Colors.gray400
                    }
                }).disposed(by: disposeBag)
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

    func cancelButtonTap() {
        cancelButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.nicknameTF.text = ""
        }).disposed(by: disposeBag)
    }

    private func keyboardBind() {
        let keyboardWillShowObservable = NotificationCenter.default.rx.notification(
            UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 48 }

        let keyboardWillHideObservable = NotificationCenter.default.rx.notification(
            UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(48) }

        Observable.merge(keyboardWillShowObservable)
            .subscribe(onNext: { [weak self] height in

                self?.checkButton.snp.remakeConstraints {
                    self!.bottomConstraint = $0.bottom.equalToSuperview().offset(-height).constraint
                    $0.width.equalToSuperview()
                    $0.height.equalTo(58.0)
                }
                self?.checkButton.layer.cornerRadius = 0
                UIView.animate(withDuration: 0.3) {
                    self?.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)

        Observable.merge(keyboardWillHideObservable)
            .subscribe(onNext: { [weak self] height in
                self?.checkButton.snp.remakeConstraints {
                    self!.bottomConstraint?.update(offset: -height + 112.0)
                    $0.leading.equalToSuperview().offset(20.0)
                    $0.trailing.equalToSuperview().offset(-20.0)
                    $0.width.equalTo(390.0)
                    $0.height.equalTo(58.0)
                    $0.bottom.equalTo((self?.view.safeAreaLayoutGuide)!)
                }
                self?.checkButton.layer.cornerRadius = 8.0
                UIView.animate(withDuration: 0.3) {
                    self?.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
    }
}
