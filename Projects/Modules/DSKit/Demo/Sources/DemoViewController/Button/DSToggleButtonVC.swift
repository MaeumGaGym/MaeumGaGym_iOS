import UIKit
import DSKit
import SnapKit
import Then

public class DSToggleButtonVC: UIViewController {
    
    var album = MaeumGaGymToggleButton(type: .album)
    var image = MaeumGaGymToggleButton(type: .image)
    var metronome = MaeumGaGymToggleButton(type: .metronome)
    var timer = MaeumGaGymToggleButton(type: .timer)

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        [
            album,
            image,
            metronome,
            timer
        ].forEach { view.addSubview($0) }

        album.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
            $0.height.equalTo(64.0)
        }
        
        image.snp.makeConstraints {
            $0.top.equalTo(album.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
            $0.height.equalTo(64.0)
        }
        
        metronome.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
            $0.height.equalTo(64.0)
        }
        
        timer.snp.makeConstraints {
            $0.top.equalTo(metronome.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
            $0.height.equalTo(64.0)
        }
    }
}
