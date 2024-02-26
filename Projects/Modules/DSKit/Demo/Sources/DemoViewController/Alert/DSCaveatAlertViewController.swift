import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import DSKit

public class DSCaveatAlertViewController: UIViewController {
    
    let caveatAlertButton = MGButton(
        titleText: "caveatAlert",
        backColor: .red
    )

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(caveatAlertButton)

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
