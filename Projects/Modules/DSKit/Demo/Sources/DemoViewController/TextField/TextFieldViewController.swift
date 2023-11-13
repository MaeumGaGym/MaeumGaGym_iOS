import UIKit
import DSKit
import SnapKit
import Then

public class TextFieldViewController: UIViewController {
    
    private let nicknameTF = AuthTextField(placeholder: "닉네임")
    private let passwordTF = AuthTextField(placeholder: "비밀번호")
    private let emailTF = AuthTextField(placeholder: "이메일")
    private let certificationTF = AuthTextField(placeholder: "인증번호")


    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        nicknameTF.useShowHideButton = false

        passwordTF.useShowHideButton = true
        passwordTF.isTextHidden = true
        
        
        emailTF.useShowHideButton = false
        
        certificationTF.useShowHideButton = false
        certificationTF.useTimer = true
        certificationTF._timerState.accept(.started)
        
        layout()
    }
    
    func layout() {
        [
            nicknameTF,
            passwordTF,
            emailTF,
            certificationTF,
        ].forEach { view.addSubview($0) }
        
        nicknameTF.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(58.0)
        }
        
        passwordTF.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(nicknameTF.snp.bottom).offset(40.0)
            $0.height.equalTo(58.0)
        }
        
        emailTF.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(passwordTF.snp.bottom).offset(40.0)
            $0.height.equalTo(58.0)
        }
        
        certificationTF.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(emailTF.snp.bottom).offset(40.0)
            $0.height.equalTo(58.0)
        }
    }
    
}
