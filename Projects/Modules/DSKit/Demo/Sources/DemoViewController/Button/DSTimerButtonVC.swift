import UIKit
import DSKit
import SnapKit
import Then

public class DSTimerButtonVC: UIViewController {
    
    var cancelButton = MGTimerButton(type: .close)
    var restartButton = MGTimerButton(type: .restart)
    var startButton = MGTimerButton(type: .start)
    var stopButton = MGTimerButton(type: .stop)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
            $0.width.height.equalTo(68.0)
        }
        
        restartButton.snp.makeConstraints {
            $0.top.equalTo(cancelButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(68.0)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(restartButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(68.0)
        }
        
        stopButton.snp.makeConstraints {
            $0.top.equalTo(startButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(68.0)
        }
    }
}
