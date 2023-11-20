import UIKit
import SnapKit
import Then
import Core
import RxFlow
import RxCocoa
import RxSwift
import DSKit

public class StartViewController: BaseViewController<StartViewModel> {
    
    public var steps = PublishRelay<Step>()
    
    public var initialStep: Step {
        AppStep.homeIsRequired
    }
    
    private var mainTitle = UILabel().then {
        $0.font = UIFont.Pretendard.titleMedium
        $0.text = "이제 헬창이 되어보세요!"
        $0.textColor = .black
    }
    
    private var subTitle = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
        $0.text = "저희의 좋은 서비스를 통해 즐거운 헬창 생활을\n즐겨보세요!"
        $0.numberOfLines = 2
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private var googleButton = MaeumGaGymAuthButton(type: .google)

    private var kakaoButton = MaeumGaGymAuthButton(type: .kakao)
        
    private var appleButton = MaeumGaGymAuthButton(type: .apple)
    
    
    public override func attribute() {
        super.attribute()
        self.view.backgroundColor = .systemBackground
    }
    
    public override func layout() {
        super.layout()
        
        [
            mainTitle,
            subTitle,
            googleButton,
            kakaoButton,
            appleButton
        ].forEach { view.addSubview($0) }
        
        mainTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        subTitle.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(12.0)
            $0.centerX.equalTo(mainTitle.snp.centerX)
        }
        
        googleButton.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(100.0)
            $0.centerX.equalTo(subTitle.snp.centerX)
            $0.width.equalToSuperview().offset(-16.0)
            $0.height.equalTo(60.0)
        }
        
        kakaoButton.snp.makeConstraints {
            $0.top.equalTo(googleButton.snp.bottom).offset(16.0)
            $0.centerX.equalTo(googleButton.snp.centerX)
            $0.width.equalTo(googleButton.snp.width)
            $0.height.equalTo(googleButton.snp.height)
        }
        
        appleButton.snp.makeConstraints {
            $0.top.equalTo(kakaoButton.snp.bottom).offset(16.0)
            $0.centerX.equalTo(kakaoButton.snp.centerX)
            $0.width.equalTo(kakaoButton.snp.width)
            $0.height.equalTo(kakaoButton.snp.height)
        }
    }
}
