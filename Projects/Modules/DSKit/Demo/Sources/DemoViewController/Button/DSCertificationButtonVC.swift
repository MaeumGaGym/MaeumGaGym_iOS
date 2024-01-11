import UIKit
import DSKit
import SnapKit
import Then

public class DSCertificationButtonVC: UIViewController {
    
    let certificationButton1 = MaeumGaGymCertificationButton(text: "문자 다시 받기", font: UIFont.Pretendard.bodyMedium)
    let certificationButton2 = MaeumGaGymCertificationButton(text: "인증 요청", font: UIFont.Pretendard.bodySmall)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        [
            certificationButton1,
            certificationButton2
        ].forEach { view.addSubview($0) }
        
        certificationButton1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        certificationButton2.snp.makeConstraints {
            $0.top.equalTo(certificationButton1.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
        }
    }
}
