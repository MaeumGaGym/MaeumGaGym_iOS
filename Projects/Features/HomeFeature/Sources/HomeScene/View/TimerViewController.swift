import UIKit
import SnapKit
import Then
import DSKit
import RxSwift
import DSKit

public class TimerViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var toggleView = MaeumGaGymProgressBarView(center: view.center, radius: 175.0, color: DSKitAsset.Colors.blue500.color)
    
    private let closeButton = MaeumGaGymTimerButton(type: .close)
    private let stopButton = MaeumGaGymTimerButton(type: .stop, radius: 40.0)
    private let startButton = MaeumGaGymTimerButton(type: .start, radius: 40.0)
    private let restartButton = MaeumGaGymTimerButton(type: .restart)

    
//    MaeumGaGymToggleView(width: 430.0, height: 793.0)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
        toggleView.setting(for: 60)
        buttonTap()
    }

    func layout() {
        [
            toggleView,
            closeButton,
            stopButton,
            startButton,
            restartButton
        ].forEach { view.addSubview($0) }
        
        toggleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(141.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(350.0)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(toggleView.snp.bottom).offset(225.0)
            $0.leading.equalToSuperview().offset(83.0)
        }
        
        stopButton.snp.makeConstraints {
            $0.top.equalTo(toggleView.snp.bottom).offset(219.0)
            $0.leading.equalTo(closeButton.snp.trailing).offset(24.0)

        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(toggleView.snp.bottom).offset(219.0)
            $0.leading.equalTo(closeButton.snp.trailing).offset(24.0)

        }
        
        restartButton.snp.makeConstraints {
            $0.top.equalTo(toggleView.snp.bottom).offset(225.0)
            $0.trailing.equalToSuperview().offset(-83.0)
            
        }
    }
    
    private func buttonTap() {
        startButton.rx.tap
            .subscribe(onNext: { [self] in
                if toggleView.startTimer() {
                    stopButton.isHidden = false
                    startButton.isHidden = true
                }
            })
            .disposed(by: disposeBag)
        
        stopButton.rx.tap
            .subscribe(onNext: { [self] in
                toggleView.stopTimer()
                stopButton.isHidden = true
                startButton.isHidden = false
            })
            .disposed(by: disposeBag)
        
        restartButton.rx.tap
            .subscribe(onNext: { [self] in
                toggleView.restartTimer()
                if startButton.isHidden == true {
                    stopButton.isHidden = true
                    startButton.isHidden = false
                }
            }).disposed(by: disposeBag)
        
        closeButton.rx.tap
            .subscribe(onNext: { [self] in
                toggleView.closeTimer()
                if startButton.isHidden == true {
                    stopButton.isHidden = true
                    startButton.isHidden = false
                }
            }).disposed(by: disposeBag)
    }
}

