import UIKit

import DSKit
import SnapKit
import Then

open class DSPostureInfoLabelVC: UIViewController {

    private let postureInfoTitle1 = MGPostureInfoLabel(titleNumber: "01",
                                                       text: "양팔을 가슴 옆에 두고 바닥에 엎드립니다.")
    private let postureInfoTitle2 = MGPostureInfoLabel(titleNumber: "02",
                                                       text: "복근과 둔근에 힘을 준 상태로 팔꿈치를 피며\n올라옵니다.",
                                                       numberOfLines: 2)
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        view.addSubviews([postureInfoTitle1, postureInfoTitle2])
        
        postureInfoTitle1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview().inset(20.0)
            $0.height.equalTo(32.0)
        }
        
        postureInfoTitle2.snp.makeConstraints {
            $0.top.equalTo(postureInfoTitle1.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview().inset(20.0)
            $0.height.equalTo(52.0)
        }
    }
}
