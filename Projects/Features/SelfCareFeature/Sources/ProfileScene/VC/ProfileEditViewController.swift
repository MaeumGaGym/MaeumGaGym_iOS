import UIKit

import Then
import SnapKit

import RxSwift
import RxCocoa

import Core
import DSKit

final public class SelfCareProfileEditViewController: BaseViewController<SelfCareProfileEditViewModel> {
    
    private var genderType = PublishRelay<String>()

    private var bottomConstraint: Constraint?

    private lazy var navBar = SelfCareProfileNavigationBar(leftText: "내 정보 변경")
    private let nameTextField = MGSelfCareTextField(typeText: "이름", keyboardType: .default, placeholderText: "이름")
    private let heightTextField = MGSelfCareTextField(typeText: "키", keyboardType: .numberPad, unitText: "cm", placeholderText: "키")
    private let weightTextField = MGSelfCareTextField(typeText: "몸무게", keyboardType: .numberPad, unitText: "kg", placeholderText: "몸무게")
    private lazy var genderDropDown = MGDropDown(genderData: { gender in
        self.genderType.accept(gender)
    })
    private let endButton = MGButton(
        titleText: "확인",
        font: UIFont.Pretendard.labelLarge,
        textColor: .white,
        backColor: DSKitAsset.Colors.blue500.color
    ).then {
        $0.isHidden = true
    }

    private let editFinishButton = MGButton(
        titleText: "수정 완료",
        font: UIFont.Pretendard.labelLarge,
        textColor: .white,
        backColor: DSKitAsset.Colors.blue500.color
    ).then {
        $0.layer.cornerRadius = 8
    }

    public override func configureNavigationBar() {
        super.configureNavigationBar()

        navigationController?.isNavigationBarHidden = true
    }
    public override func attribute() {
        super.attribute()

        view.backgroundColor = .white
        setupKeyboardObservers()
    }
    public override func bindActions() {
        endButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.view.endEditing(true)
            }).disposed(by: disposeBag)
    }
    public override func bindViewModel() {
        let input = SelfCareProfileEditViewModel.Input(
            name: nameTextField.rx.text.orEmpty.asDriver(),
            height: heightTextField.rx.text.orEmpty.asDriver(),
            weight: weightTextField.rx.text.orEmpty.asDriver(),
            gender: genderType.asDriver(onErrorJustReturn: ""),
            profileEditButtonClick: editFinishButton.rx.tap.asDriver(),
            popVCButton: navBar.leftButtonTap.asDriver()
        )
        
        _ = viewModel.transform(input, action: { output in
            print(output.nickName)
        })
    }

    public override func layout() {
        super.layout()

        view.addSubviews([
            navBar,
            nameTextField,
            heightTextField,
            weightTextField,
            genderDropDown,
            endButton,
            editFinishButton
        ])

        navBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom).offset(52)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        heightTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        weightTextField.snp.makeConstraints {
            $0.top.equalTo(heightTextField.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        genderDropDown.snp.makeConstraints {
            $0.top.equalTo(weightTextField.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(185)
        }
        endButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(54)
            $0.height.equalTo(58)
        }
        editFinishButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(54)
            $0.height.equalTo(58)
        }
    }
}

extension SelfCareProfileEditViewController {
    private func setupKeyboardObservers() {
        keyboardBind()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
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
                owner.endButton.isHidden = false
                owner.endButton.snp.remakeConstraints {
                    owner.bottomConstraint = $0.bottom.equalToSuperview().offset(-height).constraint
                    $0.width.equalToSuperview()
                    $0.height.equalTo(58.0)
                }
                UIView.animate(withDuration: 0.3) {
                    owner.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)

        Observable.merge(keyboardWillHideObservable)
            .withUnretained(self)
            .subscribe(onNext: { owner, height in
                owner.endButton.snp.remakeConstraints {
                    owner.bottomConstraint?.update(offset: -height + 112.0)
                    $0.leading.equalToSuperview().offset(20.0)
                    $0.trailing.equalToSuperview().offset(-20.0)
                    $0.width.equalTo(390.0)
                    $0.height.equalTo(58.0)
                    $0.bottom.equalTo((owner.view.safeAreaLayoutGuide))
                }
                owner.endButton.isHidden = true
                UIView.animate(withDuration: 0.3) {
                    owner.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
    }

}
