import UIKit
import DSKit
import SnapKit
import Then

public class DSCheckButtonVC: UIViewController {
    
    var checkButton = MaeumGaGymCheckButton(text: "asdf")
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        [
            checkButton
        ].forEach { view.addSubview($0) }
        
        checkButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(70.0)
            $0.width.equalTo(48.0)
        }
    }
}
