import UIKit
import DSKit
import SnapKit
import Then

open class DSLabelViewController: UIViewController {
    
    private let telUILabel = MGLabel(
        text: "휴대폰 번호",
        font: UIFont.Pretendard.titleLarge
    )
    
    private let textInformation = MGLabel(
        text: "본인확인을 위해 휴대폰 번호를 입력해 주세요.",
        font: UIFont.Pretendard.bodyMedium,
        textColor: DSKitAsset.Colors.gray600.color
    )
    
    private let firstTimerTitle = MGLabel(
        text: "4분",
        font: UIFont.Pretendard.bodyLarge,
        textColor: .black
    )
    
    private let secondTimerTitle = MGLabel(
        text: "04 : 00",
        font: UIFont.Pretendard.light,
        textColor: .black
    )
    
    private let thirdTimerTitle = MGLabel(
        text: "오전 8:09",
        font: UIFont.Pretendard.bodyMedium,
        textColor: .black
    )
    
    private let tagLabel1 = MGTagLabel(text: "맨몸")
    private let tagLabel2 = MGTagLabel(text: "가슴")
    
    private let postureInfoTitle1 = MGPostureInfoLabel(titleNumber: "01", text: "양팔을 가슴 옆에 두고 바닥에 엎드립니다.")
    private let postureInfoTitle2 = MGPostureInfoLabel(titleNumber: "02", text: "복근과 둔근에 힘을 준 상태로 팔꿈치를 피며\n올라옵니다.", numberOfLines: 2)
    
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
            thirdTimerTitle,
            tagLabel1,
            tagLabel2,
            postureInfoTitle1,
            postureInfoTitle2
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
        
        tagLabel1.snp.makeConstraints {
            $0.top.equalTo(thirdTimerTitle.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }
        
        tagLabel2.snp.makeConstraints {
            $0.top.equalTo(thirdTimerTitle.snp.bottom).offset(8.0)
            $0.leading.equalTo(tagLabel1.snp.trailing).offset(100.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }
        
        postureInfoTitle1.snp.makeConstraints {
            $0.top.equalTo(tagLabel1.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview().inset(20.0)
            $0.height.equalTo(32.0)
        }
        
        postureInfoTitle2.snp.makeConstraints {
            $0.top.equalTo(postureInfoTitle1.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview().inset(20.0)
            $0.height.equalTo(52.0)
        }
    }
}