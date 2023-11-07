import UIKit
import DSKit
import SnapKit
import Then

public class ButtonViewController: UIViewController {
    
    var kakaoButton = MaeumGaGymAuthButton(type: .kakao)
    var googleButton = MaeumGaGymAuthButton(type: .google)
    var appleButton = MaeumGaGymAuthButton(type: .apple)
    
    let certificationButton1 = CertificationButton(text: "문자 다시 받기", font: UIFont.Pretendard.bodyMedium)
    let certificationButton2 = CertificationButton(text: "인증 요청", font: UIFont.Pretendard.bodySmall)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        [
            kakaoButton,
            googleButton,
            appleButton,
            certificationButton1,
            certificationButton2
        ].forEach { view.addSubview($0) }

        kakaoButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
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
        
        certificationButton1.snp.makeConstraints {
            $0.top.equalTo(appleButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
        }
        
        certificationButton2.snp.makeConstraints {
            $0.top.equalTo(certificationButton1.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
        }
    }
}
