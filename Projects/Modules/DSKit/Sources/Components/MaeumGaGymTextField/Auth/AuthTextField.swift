import UIKit
import Then
import SnapKit
import Core
import RxSwift
import RxCocoa
import DSKit

public enum TimerState { case started, stopped }

open class AuthTextField: UITextField {
    
    private let disposeBag = DisposeBag()
    private var countdownDisposable: Disposable?
    
    private var countdownTimer: Timer?
    private var remainingSeconds = 180
        
    public let _timerState = BehaviorRelay<TimerState>(value: .stopped)
    
    public var timerState: Driver<TimerState> {
        return _timerState.asDriver(onErrorJustReturn: .stopped)
    }
        
    private let placeholderLabel = UILabel().then {
        $0.font = UIFont.Pretendard.titleMedium
        $0.textColor = DSKitAsset.Colors.gray200.color
    }
    
    private let underlineView = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray900.color
    }
    
    private let errorLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodySmall
        $0.textColor = DSKitAsset.Colors.red500.color
        $0.isHidden = true
    }

    private let showHideButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.eyeOff.image, for: .normal)
        $0.setImage(DSKitAsset.Assets.eye.image, for: .selected)
        $0.tintColor = DSKitAsset.Colors.gray900.color
        $0.contentMode = .scaleAspectFit
    }

    private var timerLabel = UILabel().then {
        $0.text = "03:00"
        $0.textColor = DSKitAsset.Colors.gray200.color
        $0.font = UIFont.Pretendard.titleMedium
    }

    private let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))

    public var showError: Bool = false {
        didSet {
            errorLabel.isHidden = !showError
            underlineView.backgroundColor = showError ? UIColor.red : UIColor.black
            placeholderLabel.textColor = showError ? UIColor.red : UIColor.gray
            showHideButton.tintColor = showError ? UIColor.red : UIColor.black
            timerLabel.textColor = showError ? UIColor.red : UIColor.blue
            textColor = showError ? UIColor.red : UIColor.black
        }
    }

    public var errorMessage: String? {
        didSet {
            errorLabel.text = errorMessage
        }
    }

    public var useShowHideButton: Bool = true {
        didSet {
            showHideButton.isHidden = !useShowHideButton
        }
    }

    public var isTextHidden: Bool = false {
        didSet {
            if isSecureTextEntry && !isTextHidden {
                showHideButton.isSelected = true
                isSecureTextEntry = false
            } else if isTextHidden {
                isSecureTextEntry = true
                showHideButton.isSelected = false
            }
        }
    }

    public var useTimer: Bool = false {
        didSet {
            if useTimer {
                configureTimerLabel()
            }
        }
    }

    public var emailErrorType: TextFieldErrorType.Email? {
        didSet {
            if let errorType = emailErrorType {
                errorMessage = errorType.message
                showError = errorType.showError
            }
        }
    }
    
    public var passwordErrorType: TextFieldErrorType.Password? {
        didSet {
            if let errorType = passwordErrorType {
                errorMessage = errorType.message
                showError = errorType.showError
            }
        }
    }
    
    public var codeErrorType: TextFieldErrorType.Code? {
        didSet {
            if let errorType = codeErrorType {
                errorMessage = errorType.message
                showError = errorType.showError
            }
        }
    }
    
    public var nameErrorType: TextFieldErrorType.Name? {
        didSet {
            if let errorType = nameErrorType {
                errorMessage = errorType.message
                showError = errorType.showError
            }
        }
    }
    
    public var ageErrorType: TextFieldErrorType.Age? {
        didSet {
            if let errorType = ageErrorType {
                errorMessage = errorType.message
                showError = errorType.showError
            }
        }
    }
    
    public var idErrorType: TextFieldErrorType.ID? {
        didSet {
            if let errorType = idErrorType {
                errorMessage = errorType.message
                showError = errorType.showError
            }
        }
    }
    
    public var heightErrorType: TextFieldErrorType.Height? {
        didSet {
            if let errorType = heightErrorType {
                errorMessage = errorType.message
                showError = errorType.showError
            }
        }
    }
    
    public var weightErrorType: TextFieldErrorType.Weight? {
        didSet {
            if let errorType = weightErrorType {
                errorMessage = errorType.message
                showError = errorType.showError
            }
        }
    }
    
    public override var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
            super.placeholder = ""
        }
    }
    
    public convenience init(placeholder: String) {
        self.init(frame: .zero)
        
        placeholderLabel.text = placeholder
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        configure()
        delegate = self
        
        _ = timerState
            .drive(with: self, onNext: { owner, state in
                owner.setupTimer(state: state)
            })

        self.tintColor = .black
    }
    
    private func configure() {
        addSubview(placeholderLabel)
        addSubview(underlineView)
        addSubview(showHideButton)
        addSubview(errorLabel)
        
        placeholderLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(underlineView.snp.top).offset(-8)
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        underlineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        errorLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(underlineView.snp.bottom).offset(4)
        }
        
        if useShowHideButton {
            addSubview(showHideButton)
            showHideButton.snp.makeConstraints {
                $0.trailing.equalToSuperview()
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(20)
            }
            
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
            rightViewMode = .always
        } else {
            rightView = nil
            rightViewMode = .never
        }
    }
    
    private func togglePasswordVisibility() {
        isTextHidden.toggle()
        print("asdf")
    }
    
    private func setupTimer(state: TimerState) {
        switch state {
        case .started:
            countdownDisposable = Observable<Int>
                .interval(.seconds(1), scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] _ in
                    self?.updateTimer()
                })
        case .stopped:
            countdownDisposable?.dispose()
            remainingSeconds = 180
            updateTimerLabel()
        }
    }
    
    private func updateTimer() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1
            updateTimerLabel()
        } else {
            _timerState.accept(.stopped)
        }
    }
    
    private func updateTimerLabel() {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func configureTimerLabel() {
        addSubview(timerLabel)
        
        timerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(-8)
            $0.width.equalTo(66)
            $0.height.equalTo(30)
        }

        rightViewMode = .always
    }
}

extension AuthTextField: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.placeholderLabel.font = UIFont.Pretendard.bodySmall
            self.placeholderLabel.snp.updateConstraints {
                $0.bottom.equalTo(self.underlineView.snp.top).offset(-(self.placeholderLabel.frame.size.height + 4))
            }
            self.layoutIfNeeded()
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            UIView.animate(withDuration: 0.3) {
                self.placeholderLabel.font = UIFont.Pretendard.bodyMedium
                self.placeholderLabel.snp.updateConstraints {
                    $0.bottom.equalTo(self.underlineView.snp.top).offset(-4)
                }
                self.layoutIfNeeded()
            }
        }


    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            let location = touch.location(in: self)
            if showHideButton.frame.contains(location) {
                togglePasswordVisibility()
            }
        }
    }
}

extension Reactive where Base: AuthTextField {
    var timerState: Driver<TimerState> {
        return base._timerState.asDriver(onErrorJustReturn: .stopped)
    }
}

