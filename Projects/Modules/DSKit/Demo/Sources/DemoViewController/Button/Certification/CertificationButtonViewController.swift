import Foundation
import UIKit
import DSKit
import SnapKit
import Then

public class CertificationButtonViewController: UIViewController {
    
    var certificationButton = CertificationButton(widthValue: 73, heightValue: 30, text: "인증완료", font: UIFont.Pretendard.bodySmall)
    var messageAgainButton = CertificationButton(widthValue: 123, heightValue: 40, text: "문자 다시 받기", font: UIFont.Pretendard.bodySmall) // 여기 디자인에 폰트가 제대로 안나와 있어서 디자인이 바꿔주면 바꿔야해요

    
  
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
    
    func layout() {
        [certificationButton, messageAgainButton].forEach { view.addSubview($0) }

        certificationButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
            $0.centerX.equalToSuperview()
        }
        
        messageAgainButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100.0)
            $0.centerX.equalToSuperview()
        }
    }
}
