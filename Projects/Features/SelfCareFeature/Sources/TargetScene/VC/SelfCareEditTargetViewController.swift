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
import Data
import MGNetworks

import SelfCareFeatureInterface

final public class SelfCareEditTargetViewController: BaseViewController<SelfCareEditTargetViewModel> {

    private var bottomConstraint: Constraint?
    
    public var id: Int = 0
    
    private var startDate = BehaviorRelay<String>(value: "")
    private var endDate = BehaviorRelay<String>(value: "")

    private lazy var navBar = SelfCareProfileNavigationBar(leftText: "목표 수정")
    private let titleTextField = MGSelfCareTextField(
        typeText: "제목",
        keyboardType: .default,
        placeholderText: "제목을 입력해주세요",
        placeholderTextColor: .gray400
    )
    private let startDateSelectView = MGDateSelectView(typeText: "시작 날짜")
    private let endDateSelectView = MGDateSelectView(typeText: "마감 날짜")
    private let contentTextView = MGTextView()
    private let endButton = MGButton(
        titleText: "확인",
        font: UIFont.Pretendard.labelLarge,
        textColor: .white,
        backColor: .blue500
    ).then {
        $0.isHidden = true
    }

    private let editFinishButton = MGButton(
        titleText: "완료",
        font: UIFont.Pretendard.labelLarge,
        textColor: .white,
        backColor: .blue500
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
        navBar.leftButtonTap
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)

        endButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.view.endEditing(true)
            }).disposed(by: disposeBag)

        editFinishButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)

//        startDateSelectView.dateButtonTap
//            .bind(onNext: { [weak self] in
//                let vc = MGTargetAlertView(clickDate: { date in
////                    self?.startDateSelectView.setup(date: [year!, month!, day!])
//                    self?.startDate.accept(date ?? "")
//                    self?.startDateSelectView.setup(date: date ?? "")
//                    print(date)
////                    print(self?.startDate.value.changeDateFormat(type: .fullDate))
//                })
//                
//                vc.modalTransitionStyle = .crossDissolve
//                vc.modalPresentationStyle = .overFullScreen
//                self?.present(vc, animated: true)
//            }).disposed(by: disposeBag)

        endDateSelectView.dateButtonTap
            .bind(onNext: { [weak self] in
                let vc = MGTargetAlertView()
                vc.clickDate = { date in
                    self?.endDate.accept(date ?? "")
                    self?.endDateSelectView.setupDate(date: date ?? "")
//                    self?.endDateSelectView.setup(date: [year!, month!, day!])
//                    self?.endDate.accept("\(year ?? 0)\(month ?? 0)\(day ?? 0)")
                }
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self?.present(vc, animated: true)
            }).disposed(by: disposeBag)
    }
    public override func bindViewModel() {
//        let useCase = DefaultSelfCareUseCase(repository: SelfCareRepository(networkService: DefaultSelfCareService()))
//
//        viewModel = SelfCareAddTargetViewModel(useCase: useCase)
        
        let input = SelfCareEditTargetViewModel.Input(
            id: Driver.just(id),
            title: titleTextField.rx.text.orEmpty.asDriver(),
            startDate: startDate.asDriver(onErrorDriveWith: .never()),
            endDate: endDate.asDriver(onErrorDriveWith: .never()),
            content: contentTextView.textView.rx.text.orEmpty.asDriver(),
            editTargetButton: editFinishButton.rx.tap.asDriver()
        )
        
        _ = viewModel.transform(input, action: { output in
        })
    }
    public override func layout() {
        super.layout()

        view.addSubviews([
            navBar,
            titleTextField,
            startDateSelectView,
            endDateSelectView,
            contentTextView,
            endButton,
            editFinishButton
        ])

        navBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom).offset(52)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        startDateSelectView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        endDateSelectView.snp.makeConstraints {
            $0.top.equalTo(startDateSelectView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(endDateSelectView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(228)
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

extension SelfCareEditTargetViewController {
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
