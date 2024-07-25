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

final public class SelfCareAddTargetViewController: BaseViewController<SelfCareAddTargetViewModel> {

    private var bottomConstraint: Constraint?
    
    private var startDate = BehaviorRelay<String>(value: "")
    private var endDate = BehaviorRelay<String>(value: "")

    private lazy var navBar = SelfCareProfileNavigationBar(leftText: "목표 추가")
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

    private lazy var startCalendarAlertViewController: MGTargetAlertView = {
        let viewController = MGTargetAlertView()
        viewController.view.isHidden = true
        viewController.clickDate = { [weak self] date in
            self?.startDate.accept(date ?? "")
            self?.startDateSelectView.setupDate(date: date ?? "")
            self?.hideStartCalendar()
        }
        return viewController
    }()

    private lazy var endCalendarAlertViewController: MGTargetAlertView = {
        let viewController = MGTargetAlertView()
        viewController.view.isHidden = true
        viewController.clickDate = { [weak self] date in
            self?.endDate.accept(date ?? "")
            self?.endDateSelectView.setupDate(date: date ?? "")
            self?.hideEndCalendar()
        }
        return viewController
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        attribute()
        layout()
        bindActions()
        bindViewModel()
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

        startDateSelectView.dateButtonTap
            .bind(onNext: { [weak self] in
                self?.showStartCalendar()
            }).disposed(by: disposeBag)

        endDateSelectView.dateButtonTap
            .bind(onNext: { [weak self] in
                self?.showEndCalendar()
            }).disposed(by: disposeBag)
    }

    public override func bindViewModel() {
        let input = SelfCareAddTargetViewModel.Input(
            title: titleTextField.rx.text.orEmpty.asDriver(),
            startDate: startDate.asDriver(onErrorDriveWith: .never()),
            endDate: endDate.asDriver(onErrorDriveWith: .never()),
            content: contentTextView.textView.rx.text.orEmpty.asDriver(),
            addTargetButton: editFinishButton.rx.tap.asDriver()
        )
        
        _ = viewModel.transform(input, action: { output in
            output
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

        setupStartCalendarAlertViewController()
        setupEndCalendarAlertViewController()
    }

    private func setupStartCalendarAlertViewController() {
        addChild(startCalendarAlertViewController)
        view.addSubview(startCalendarAlertViewController.view)
        startCalendarAlertViewController.didMove(toParent: self)
        
        startCalendarAlertViewController.view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(startDateSelectView.snp.bottom).offset(25)
            $0.height.equalTo(348)
        }
    }

    private func setupEndCalendarAlertViewController() {
        addChild(endCalendarAlertViewController)
        view.addSubview(endCalendarAlertViewController.view)
        endCalendarAlertViewController.didMove(toParent: self)
        
        endCalendarAlertViewController.view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(endDateSelectView.snp.bottom).offset(25)
            $0.height.equalTo(348)
        }
    }

    private func showStartCalendar() {
        startCalendarAlertViewController.view.isHidden = false
        startCalendarAlertViewController.view.alpha = 0.0
        startDateSelectView.setup(selcect: true)
        
        UIView.animate(withDuration: 0.3) {
            self.startCalendarAlertViewController.view.alpha = 1.0
        }
    }

    private func hideStartCalendar() {
        startDateSelectView.setup(selcect: false)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.startCalendarAlertViewController.view.alpha = 0.0
        }) { _ in
            self.startCalendarAlertViewController.view.isHidden = true
        }
    }

    private func showEndCalendar() {
        endCalendarAlertViewController.view.isHidden = false
        endCalendarAlertViewController.view.alpha = 0.0
        endDateSelectView.setup(selcect: true)
        
        UIView.animate(withDuration: 0.3) {
            self.endCalendarAlertViewController.view.alpha = 1.0
        }
    }

    private func hideEndCalendar() {
//        endDateSelectView.setup(typeTextColor: .black, borderColor: .gray50, backgroundColor: .gray25)
        endDateSelectView.setup(selcect: false)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.endCalendarAlertViewController.view.alpha = 0.0
        }) { _ in
            self.endCalendarAlertViewController.view.isHidden = true
        }
    }
}


extension SelfCareAddTargetViewController {
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
