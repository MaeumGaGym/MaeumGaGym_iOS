import UIKit

import RxSwift
import RxCocoa

import MGLogger
import DSKit
import Core

public class PicklePreparingViewController: BaseViewController<Any> {
    
    private let backgroundView = UIView()
    
    private let preparingImageView = UIImageView().then {
        $0.image = DSKitAsset.Assets.preparingImage.image
        $0.backgroundColor = .clear
    }
    private let preparingTitle = MGLabel(text: "피클은 아직 개발중이에요", font: UIFont.Pretendard.titleMedium, isCenter: true)
    private let preparingInfo = MGLabel(text: "현재 탭은 개발중입니다.\n빠른 시일 내에 더욱 나은 모습으로 찾아뵙겠습니다.", font: UIFont.Pretendard.bodyMedium, isCenter: true, numberOfLineCount: 2)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        print("asdfasdfasfdasdf")
    }
    
    public override func layout() {
        super.layout()

        view.addSubviews([backgroundView])
        backgroundView.addSubviews([preparingImageView, preparingTitle, preparingInfo])
        
        backgroundView.snp.makeConstraints {
            $0.centerY.equalToSuperview().inset(40.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(55.0)
            $0.height.equalTo(228)
        }
        
        preparingImageView.snp.makeConstraints {
            $0.width.height.equalTo(120.0)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        preparingTitle.snp.makeConstraints {
            $0.top.equalTo(preparingImageView.snp.bottom).offset(24.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(32.0)
            $0.centerX.equalToSuperview()
        }
        
        preparingInfo.snp.makeConstraints {
            $0.top.equalTo(preparingTitle.snp.bottom).offset(12.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(40.0)
            $0.centerX.equalToSuperview()
        }
        
    }
}
