import UIKit
import DSKit
import SnapKit
import Then

public class TextFieldViewController: UIViewController {
    
    private let authTextField = AuthTextField(placeholder: "이메일을 입력하세요")
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        authTextField.useShowHideButton = false
        authTextField.useTimer = true
        authTextField._timerState.accept(.started)
        
        layout()
    }

    func layout() {
        [
            authTextField,
        ].forEach { view.addSubview($0) }
        
        authTextField.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(353.0)
        }
    }

}
