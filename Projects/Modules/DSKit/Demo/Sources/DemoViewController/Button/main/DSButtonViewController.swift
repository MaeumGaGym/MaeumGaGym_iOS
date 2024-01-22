import UIKit
import DSKit
import SnapKit
import Then

public class DSButtonViewController: UIViewController {
    
    var kakaoButton = MGAuthButton(type: .kakao)
    var googleButton = MGAuthButton(type: .google)
    var appleButton = MGAuthButton(type: .apple)
    
    let certificationButton1 = MGCertificationButton(text: "문자 다시 받기", font: UIFont.Pretendard.bodyMedium)
    let certificationButton2 = MGCertificationButton(text: "인증 요청", font: UIFont.Pretendard.bodySmall)
    
    var hartButton = MGOpaqueIconButton(type: .heart, likeCount: 12003)
    var commentButton = MGOpaqueIconButton(type: .comment, likeCount: 1200)
    var dotsButton = MGOpaqueIconButton(type: .dots)
    var shareButton = MGOpaqueIconButton(type: .share)
    
    var checkButton = MGCheckButton(text: "asdf")
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        addView()
        layout()
    }
    
    func addView() {
        [
            kakaoButton,
            googleButton,
            appleButton,
            certificationButton1,
            certificationButton2,
            hartButton,
            commentButton,
            dotsButton,
            shareButton,
            checkButton
        ].forEach { view.addSubview($0) }
    }
    
    func layout() {
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
        
        certificationButton1.snp.makeConstraints {
            $0.top.equalTo(appleButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
        }
        
        certificationButton2.snp.makeConstraints {
            $0.top.equalTo(certificationButton1.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
        }
        
        hartButton.snp.makeConstraints {
            $0.top.equalTo(certificationButton2.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
        }
        
        commentButton.snp.makeConstraints {
            $0.top.equalTo(hartButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
        }
        
        dotsButton.snp.makeConstraints {
            $0.top.equalTo(commentButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalTo(dotsButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints {
            $0.top.equalTo(shareButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(70.0)
            $0.width.equalTo(48.0)
        }
    }
}
