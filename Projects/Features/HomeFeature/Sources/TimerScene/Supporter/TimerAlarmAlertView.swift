import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import AudioToolbox
import DSKit
import Core

public class TimerAlarmAlertView: BaseView {
    private var timerCount: Int = 0
    
    private var containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20.0
        $0.layer.shadow(color: DSKitAsset.Colors.gray50.color, alpha: 0.3, x: 0, y: 0, blur: 0, spread: 0)
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 6
    }
    private let timerImage = UIImageView().then {
        $0.image = DSKitAsset.Assets.homeTimerLogo.image
    }
    
    private let timerTitleLabel = UILabel().then {
        $0.text = "타이머"
        $0.font = UIFont.Pretendard.bodySmall
        $0.textColor = DSKitAsset.Colors.blue500.color
        $0.textAlignment = .left
    }
    
    private var finishTimerCountLabel = UILabel().then {
        $0.text = "타이머 종료"
        $0.font = UIFont.Pretendard.bodyMedium
        $0.textColor = .black
    }
    
    private var timerTimeLabel = UILabel().then {
        $0.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.Pretendard.light32.pointSize, weight: .light)
        $0.text = "-00:00:00"
    }
    
    private let clearButton = UIButton().then {
        $0.setTitle("해제", for: .normal)
        $0.titleLabel?.font = UIFont.Pretendard.titleSmall
        $0.setTitleColor(DSKitAsset.Colors.blue500.color, for: .normal)
    }
    
    private let restartButton = UIButton().then {
        $0.setTitle("다시 시작", for: .normal)
        $0.titleLabel?.font = UIFont.Pretendard.titleSmall
        $0.setTitleColor(DSKitAsset.Colors.blue500.color, for: .normal)
    }
    
    private let decorationLine = MGLine(lineHeight: 22.0).then {
        $0.layer.cornerRadius = 1
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupGesture()
        buttonTapped()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGesture()
        buttonTapped()
    }
    
    private func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        self.addGestureRecognizer(panGesture)
    }
    
    public override func attribute() {
        layer.cornerRadius = 20.0
    }
    
    public override func layout() {
        addSubview(containerView)
        containerView.addSubviews([timerImage, timerTitleLabel, finishTimerCountLabel, timerTimeLabel, clearButton, restartButton, decorationLine])
        
        containerView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        timerImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.0)
            $0.leading.equalToSuperview().offset(24.0)
            $0.width.height.equalTo(16.0)
        }
        
        timerTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.0)
            $0.leading.equalTo(timerImage.snp.trailing).offset(4.0)
            $0.height.equalTo(16.0)
        }
        
        finishTimerCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(26.0)
            $0.top.equalTo(timerTitleLabel.snp.bottom).offset(4.0)
            $0.height.equalTo(20.0)
        }
        
        timerTimeLabel.snp.makeConstraints {
            $0.top.equalTo(finishTimerCountLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().offset(24.0)
            $0.height.equalTo(48.0)
        }
        
        decorationLine.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12.0)
            $0.width.equalTo(2.0)
            $0.height.equalTo(22.0)
        }
        
        clearButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(decorationLine.snp.leading).inset(3.0)
            $0.height.equalTo(24.0)
        }
        
        restartButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12.0)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(decorationLine.snp.trailing).offset(3.0)
            $0.height.equalTo(24.0)
        }
    }
    
    private func buttonTapped() {
        clearButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.animateViewMovingUp()
            }).disposed(by: disposeBag)
        
        restartButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.animateViewMovingUp()
            }).disposed(by: disposeBag)
    }
    
    public func initializeViewPosition() {
        guard let superView = self.superview else { return }
        let totalHeight = self.frame.height + superView.frame.height - self.frame.minY
        self.transform = CGAffineTransform(translationX: 0, y: -totalHeight)
    }
    
    private func animateViewMovingUp() {
        UIView.animate(withDuration: 0.6, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        }) { _ in
            self.transform = CGAffineTransform.identity
            self.initializeViewPosition()
        }
    }

    public func moveViewDown() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
    }
    
    @objc func handleSwipe(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        
        if translation.y < 0 {
            self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        }
        
        if recognizer.state == .ended {
            let velocity = recognizer.velocity(in: self)
            if velocity.y < -500 || self.frame.minY < -100 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
                }) { _ in
                    self.initializeViewPosition()
                }
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.transform = CGAffineTransform.identity
                })
            }
        }
    }
}
