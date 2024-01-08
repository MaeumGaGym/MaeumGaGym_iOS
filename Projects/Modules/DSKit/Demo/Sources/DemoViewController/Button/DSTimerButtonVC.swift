import UIKit
import DSKit
import SnapKit
import Then

public class DSTimerButtonVC: UIViewController {
    
    var cancelButton = MaeumGaGymTimerButton(type: .close)
    var restartButton = MaeumGaGymTimerButton(type: .restart)
    var startButton = MaeumGaGymTimerButton(type: .start)
    var stopButton = MaeumGaGymTimerButton(type: .stop)

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        layout()
    }
    
    func layout() {
        [
            cancelButton,
            restartButton,
            startButton,
            stopButton
        ].forEach { view.addSubview($0) }

        cancelButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
            $0.height.equalTo(64.0)
        }
        
        restartButton.snp.makeConstraints {
            $0.top.equalTo(cancelButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
            $0.height.equalTo(64.0)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(restartButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
            $0.height.equalTo(64.0)
        }
        
        stopButton.snp.makeConstraints {
            $0.top.equalTo(startButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
            $0.height.equalTo(64.0)
        }
    }
}

