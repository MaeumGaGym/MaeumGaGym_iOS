import UIKit
import DSKit
import SnapKit
import Then

public class DSAgreeButtonVC: UIViewController {
    
    var allAgreeButton = MGAgreeButton(text: .allAgreeText)
    var agreeButton = MGAgreeButton(text: .privacyAgreeText)

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        [
            allAgreeButton,
            agreeButton
        ].forEach { view.addSubview($0) }

        allAgreeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
        }
        
        agreeButton.snp.makeConstraints {
            $0.top.equalTo(allAgreeButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width).offset(-40.0)
        }
    }
}
