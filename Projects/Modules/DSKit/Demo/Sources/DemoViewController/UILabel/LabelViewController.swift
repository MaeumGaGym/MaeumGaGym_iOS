import UIKit
import DSKit
import SnapKit
import Then

open class LabelViewController: UIViewController {
    
    private let telUILabel = MaeumGaGymLabel(text: "휴대폰 번호", font: UIFont.Pretendard.titleLarge)
    
    private let textInformation = MaeumGaGymLabel(text: "본인확인을 위해 휴대폰 번호를 입력해 주세요.", font: UIFont.Pretendard.bodyMedium, textColor: DSKitAsset.Colors.gray600.color)
    
    private let firstTimerTitle = MaeumGaGymLabel(text: "4분", font: UIFont.Pretendard.bodyLarge, textColor: .black)
    
    private let secondTimerTitle = MaeumGaGymLabel(text: "04 : 00", font: UIFont.Pretendard.light, textColor: .black)
    
    private let thirdTimerTitle = MaeumGaGymLabel(text: "오전 8:09", font: UIFont.Pretendard.bodyMedium, textColor: .black)
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        [
            telUILabel,
            textInformation,
            firstTimerTitle,
            secondTimerTitle,
            thirdTimerTitle
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
        
        firstTimerTitle.snp.makeConstraints {
            $0.top.equalTo(textInformation.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        secondTimerTitle.snp.makeConstraints {
            $0.top.equalTo(firstTimerTitle.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        thirdTimerTitle.snp.makeConstraints {
            $0.top.equalTo(secondTimerTitle.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}
