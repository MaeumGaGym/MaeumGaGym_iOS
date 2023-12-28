import UIKit
import SelfCareFeatureInterface
import DSKit
import Core

public class SelfCareViewController: UIViewController {

    private let telUILabel = MaeumGaGymAuthLabel(text: "오운완", font: UIFont.Pretendard.titleLarge)
    private let textInformation = MaeumGaGymAuthLabel(text: "오늘의 운동을 완료하고,\n내 모습을 사진으로 남겨보세요.", font: UIFont.Pretendard.bodyMedium, textColor: DSKitAsset.Colors.gray600.color)
    
    let cameraButton = MaeumGaGymCheckButton(text: "오늘의 사진 올리기", textColor: .white, backColor: DSKitAsset.Colors.blue500.color)

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        layout()
        textInformation.numberOfLines = 3
    }

    func layout() {
        [telUILabel, textInformation, cameraButton].forEach { view.addSubview($0) }

        telUILabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
        }

        textInformation.snp.makeConstraints {
            $0.top.equalTo(telUILabel.snp.bottom).offset(12.0)
            $0.leading.equalTo(telUILabel.snp.leading)
        }
        
        cameraButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(58.0)
            $0.width.equalTo(390.0)
        }
    }
}
