import UIKit
import SnapKit
import Then
import DSKit
import RxSwift
import DSKit
import Core

public class TimerViewController: BaseViewController<TimerViewModel> {
        
    lazy var progressBarView = MaeumGaGymProgressBarView(center: view.center, radius: 175.0, color: DSKitAsset.Colors.blue500.color)
    
    private let closeButton = MaeumGaGymTimerButton(type: .close)
    private let stopButton = MaeumGaGymTimerButton(type: .stop, radius: 40.0)
    private let startButton = MaeumGaGymTimerButton(type: .start, radius: 40.0)
    private let restartButton = MaeumGaGymTimerButton(type: .restart)

    
    public override func attribute() {
        view.backgroundColor = .white
        
        progressBarView.setting(for: 60)
        buttonTap()
    }

    public override func layout() {
        [
            progressBarView,
            closeButton,
            stopButton,
            startButton,
            restartButton
        ].forEach { view.addSubview($0) }
        
        progressBarView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(141.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(350.0)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(225.0)
            $0.leading.equalToSuperview().offset(83.0)
        }
        
        stopButton.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(219.0)
            $0.leading.equalTo(closeButton.snp.trailing).offset(24.0)

        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(219.0)
            $0.leading.equalTo(closeButton.snp.trailing).offset(24.0)

        }
        
        restartButton.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(225.0)
            $0.trailing.equalToSuperview().offset(-83.0)
            
        }
    }
    
    private func buttonTap() {
        startButton.rx.tap
            .subscribe(onNext: { [self] in
                if progressBarView.startTimer() {
                    stopButton.isHidden = false
                    startButton.isHidden = true
                }
            })
            .disposed(by: disposeBag)
        
        stopButton.rx.tap
            .subscribe(onNext: { [self] in
                progressBarView.stopTimer()
                stopButton.isHidden = true
                startButton.isHidden = false
            })
            .disposed(by: disposeBag)
        
        restartButton.rx.tap
            .subscribe(onNext: { [self] in
                progressBarView.restartTimer()
                if startButton.isHidden == true {
                    stopButton.isHidden = true
                    startButton.isHidden = false
                }
            }).disposed(by: disposeBag)
        
        closeButton.rx.tap
            .subscribe(onNext: { [self] in
                progressBarView.closeTimer()
                if startButton.isHidden == true {
                    stopButton.isHidden = true
                    startButton.isHidden = false
                }
            }).disposed(by: disposeBag)
    }
}

