import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import DSKit

public class DSDropDownViewController: UIViewController {
    
    let dropDown = MGDropDown()

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(dropDown)

        dropDown.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(200.0)
        }
    }
}
