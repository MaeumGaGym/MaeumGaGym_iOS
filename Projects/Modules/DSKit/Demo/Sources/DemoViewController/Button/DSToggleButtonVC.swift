import UIKit
import DSKit
import SnapKit
import Then

public class DSToggleButtonVC: UIViewController {
    
    var image = MaeumGaGymToggleButton(type: .album)
    var album = MaeumGaGymToggleButton(type: .image)
    var metronome = MaeumGaGymToggleButton(type: .metronome)
    var timer = MaeumGaGymToggleButton(type: .timer)
    var metronome1 = MaeumGaGymToggleButton(type: .metronomeHome)
    var timer1 = MaeumGaGymToggleButton(type: .timerHome)
    var morning = MaeumGaGymToggleButton(type: .morning)
    var lunch = MaeumGaGymToggleButton(type: .lunch)
    var dinner = MaeumGaGymToggleButton(type: .dinner)
    var bareBody = MaeumGaGymToggleButton(type: .bareBody)
    var marchine = MaeumGaGymToggleButton(type: .marchine)


    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        [
            image,
            album,
            metronome,
            timer,
            metronome1,
            timer1,
            morning,
            lunch,
            dinner,
            bareBody,
            marchine
        ].forEach { view.addSubview($0) }
        
        image.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(83.0)
            $0.height.equalTo(40.0)
        }
        
        album.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(120.0)
            $0.width.equalTo(83.0)
            $0.height.equalTo(40.0)
        }
        
        timer.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(92.0)
            $0.height.equalTo(40.0)
        }
        
        metronome.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100.0)
            $0.leading.equalToSuperview().offset(120.0)
            $0.width.equalTo(92.0)
            $0.height.equalTo(40.0)
        }
        
        timer1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(200.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(78.0)
            $0.height.equalTo(32.0)
        }
        
        metronome1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(200.0)
            $0.leading.equalToSuperview().offset(120.0)
            $0.width.equalTo(78.0)
            $0.height.equalTo(32.0)
        }
        
        morning.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(300.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(64.0)
            $0.height.equalTo(32.0)
        }
        
        lunch.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(300.0)
            $0.leading.equalToSuperview().offset(120.0)
            $0.width.equalTo(64.0)
            $0.height.equalTo(32.0)
        }
        
        dinner.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(300.0)
            $0.leading.equalToSuperview().offset(220.0)
            $0.width.equalTo(64.0)
            $0.height.equalTo(32.0)
        }
        
        bareBody.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(400.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }
        
        marchine.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(400.0)
            $0.leading.equalToSuperview().offset(120.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }
    }
}
