import UIKit
import DSKit
import SnapKit
import Then

public class DSSeeMoreButtonVC: UIViewController {
    
    var seeMoreButton = MaeumGaGymSeeMoreButton()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        [
            seeMoreButton
        ].forEach { view.addSubview($0) }

        seeMoreButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(74.0)
            $0.height.equalTo(24.0)
        }
    }
}
