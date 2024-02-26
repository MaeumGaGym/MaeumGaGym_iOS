import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import DSKit

public class DSDisappearAlertViewController: UIViewController {
    
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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        alertView1.present(on: self.view)
        alertView2.present(on: self.view)
        alertView3.present(on: self.view)
    }
}
