import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import DSKit

public class DSAlertViewController: UIViewController {
    
    let alertView1 = MGAlertOnlyTitleView(title: "링크가 복사되었어요").then {
        $0.titleLabel?.font = UIFont.Pretendard.labelMedium
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = DSKitAsset.Colors.gray800.color
    }
    
    let alertView2 = MGAlertBoxView(title: "링크가 복사되었어요", subtitle: nil, icon: .error).then {
        $0.titleLabel?.font = UIFont.Pretendard.labelMedium
        $0.titleLabel?.textColor = .black
        $0.backgroundColor = .gray
    }
    
    let alertView3 = MGAlertBarView(title: "링크가 복사되었어요", subtitle: nil, icon: .done).then {
        $0.titleLabel?.font = UIFont.Pretendard.labelMedium
        $0.titleLabel?.textColor = .black
        $0.backgroundColor = .gray
    }
    
    let caveatAlertButton = MGButton(
        titleText: "caveatAlert",
        backColor: .red
    )

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(caveatAlertButton)
        alertView1.present(on: self.view)
        alertView2.present(on: self.view)
        alertView3.present(on: self.view)
        
        caveatAlertButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(200.0)
        }
        
        caveatAlertButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.showCaveatPopUp(title: "회원탈퇴",
                                      message: "정말 탈퇴하실건가요?\n30일 뒤에 활동이 모두 삭제돼요.",
                                      leftActionTitle: "취소",
                                      rightActionTitle: "탈퇴",
                                      leftActionCompletion: { print("취소")},
                                      rightActionCompletion: { print("탈퇴") })
            })
    }
}
