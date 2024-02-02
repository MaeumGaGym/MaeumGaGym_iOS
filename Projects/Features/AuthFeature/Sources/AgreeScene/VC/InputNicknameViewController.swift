import UIKit
import SnapKit
import Then
import Core
import RxFlow
import RxCocoa
import RxSwift
import DSKit
import MGLogger

public class InputNicknameViewController: BaseViewController<NicknameViewModel> {

    public var steps = PublishRelay<Step>()

    public var initialStep: Step {
        AppStep.homeIsRequired
    }

    private var bottomConstraint: Constraint?

    private let nicknameTitle = MGLabel(text: "닉네임",
                                        font: UIFont.Pretendard.titleLarge,
                                        isCenter: false)

    private let textInformation = MGLabel(text: "자신만의 닉네임을 입력해 주세요.",
                                          font: UIFont.Pretendard.bodyMedium,
                                          textColor: DSKitAsset.Colors.gray600.color,
                                          isCenter: false)

    private let nicknameTF = MGTextField(placeholder: "닉네임")

    private let cancelButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.cancle.image, for: .normal)
    }

    private var checkButton = MGCheckButton(text: "회원가입")

    public override func attribute() {

        view.backgroundColor = .white

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
        self.view.addSubviews([nicknameTitle,
                               textInformation,
                               nicknameTF,
                               cancelButton,
                               checkButton])

        nicknameTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20.0)
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
