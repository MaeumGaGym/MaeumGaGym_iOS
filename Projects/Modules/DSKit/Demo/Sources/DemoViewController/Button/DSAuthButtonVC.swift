import UIKit
import DSKit
import SnapKit
import Then

public class DSAuthButtonViewController: UIViewController {
    
    var kakaoButton = MaeumGaGymAuthButton(type: .kakao)
    var googleButton = MaeumGaGymAuthButton(type: .google)
    var appleButton = MaeumGaGymAuthButton(type: .apple)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        layout()
    }
    
    func layout() {
        [
            kakaoButton,
            googleButton,
            appleButton
        ].forEach { view.addSubview($0) }

        kakaoButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
            $0.height.equalTo(64.0)
        }
        
        googleButton.snp.makeConstraints {
            $0.top.equalTo(kakaoButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
            $0.height.equalTo(64.0)
        }
        
        appleButton.snp.makeConstraints {
            $0.top.equalTo(googleButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
            $0.height.equalTo(64.0)
        }
    }
}

