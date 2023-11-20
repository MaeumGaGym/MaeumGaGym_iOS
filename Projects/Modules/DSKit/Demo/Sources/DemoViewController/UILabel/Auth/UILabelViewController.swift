import UIKit
import DSKit
import SnapKit
import Then

open class UILabelViewController: UIViewController {
    
    private let telUILabel = MaeumGaGymAuthUILabel(text: "휴대폰 번호", font: UIFont.Pretendard.titleLarge)
    
    private let textInformation = MaeumGaGymAuthUILabel(text: "본인확인을 위해 휴대폰 번호를 입력해 주세요.", font: UIFont.Pretendard.bodyMedium, textColor: DSKitAsset.Colors.gray600.color)
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        [
            telUILabel,
            textInformation,
        ].forEach { view.addSubview($0) }
        
        telUILabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(165.0)
        }
        
        textInformation.snp.makeConstraints {
            $0.top.equalTo(telUILabel.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(287.0)
        }
    }
}
