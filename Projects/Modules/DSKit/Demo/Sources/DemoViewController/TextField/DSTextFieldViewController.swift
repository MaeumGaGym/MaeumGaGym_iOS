import UIKit
import DSKit
import SnapKit
import Then
import RxSwift

public class DSTextFieldViewController: UIViewController {
    
    private var bottomConstraint: Constraint?
    
    let disposeBag = DisposeBag()
    
    private let nicknameLabel = MGLabel(text: "닉네임")
    private let nicknameInfo = MGLabel(text: "자신만의 닉네임을 입력해 주세요.", font: UIFont.Pretendard.bodyMedium)
    
    private let cancelButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.cancle.image, for: .normal)
    }
    
    public let completeButton = MGCheckButton(text: "완료")
    
    public let nicknameTF = MGTextField(placeholder: "닉네임")
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
        cancelButtonTap()
        keyboardBind()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func layout() {
        [
            nicknameLabel,
            nicknameInfo,
            nicknameTF,
            cancelButton,
            completeButton
        ].forEach { view.addSubview($0) }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(0.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(94.0)
        }
        
        nicknameInfo.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(210.0)
        }
        
        nicknameTF.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.0)
            $0.top.equalTo(nicknameInfo.snp.bottom).offset(50.0)
            $0.height.equalTo(40.0)
            $0.width.equalTo(390.0)
        }
        
        cancelButton.snp.makeConstraints {
            $0.centerY.equalTo(nicknameTF)
            $0.trailing.equalTo(nicknameTF).offset(-10)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        completeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            
        }
    }
    
    func animateButtonWithKeyboard(notification: NSNotification, show: Bool) {
        guard let keyboardSize = (notification
            .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let keyboardAnimationDuration = notification
            .userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else {
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
        let keyboardWillShowObservable = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 48 }
        
        let keyboardWillHideObservable = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(48) }
        
        Observable.merge(keyboardWillShowObservable)
            .subscribe(onNext: { [weak self] height in
                
                self?.completeButton.snp.remakeConstraints {
                    self!.bottomConstraint = $0.bottom.equalToSuperview().offset(-height).constraint
                    $0.width.equalToSuperview()
                    $0.height.equalTo(58.0)
                }
                self?.completeButton.layer.cornerRadius = 0
                UIView.animate(withDuration: 0.3) {
                    self?.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
        
        Observable.merge(keyboardWillHideObservable)
            .subscribe(onNext: { [weak self] height in
                self?.completeButton.snp.remakeConstraints {
                    self?.bottomConstraint?.update(offset: -height + 112.0)
                    $0.leading.equalToSuperview().offset(20.0)
                    $0.trailing.equalToSuperview().offset(-20.0)
                    $0.width.equalTo(390.0)
                    $0.height.equalTo(58.0)
                    $0.bottom.equalTo((self?.view.safeAreaLayoutGuide)!)
                }
                self?.completeButton.layer.cornerRadius = 8.0
                UIView.animate(withDuration: 0.3) {
                    self?.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
    }
}
