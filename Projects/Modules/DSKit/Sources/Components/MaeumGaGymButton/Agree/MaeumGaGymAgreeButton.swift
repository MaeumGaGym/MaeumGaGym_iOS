import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

open class MaeumGaGymAgreeButton: UIButton {
    
//    public let isChecked = BehaviorRelay<Bool>(value: false)
    
    public var checked: Bool = false
    public let disposeBag = DisposeBag()
    
    public let iconImageView = UIImageView().then {
        $0.image = DSKitAsset.Assets.noCheck.image
    }
    
    public let textLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    public let chooseLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = UIFont.Pretendard.bodyMedium
        $0.textColor = DSKitAsset.Colors.gray400.color
        $0.text = "(선택)"
        $0.isHidden = true
    }
    
    public let readMore = UIButton().then {
        $0.setTitle("자세히 보기", for: .normal)
        $0.titleLabel?.font = UIFont.Pretendard.labelSmall
        $0.setTitleColor(DSKitAsset.Colors.gray300.color, for: .normal)
        $0.isHidden = false
    }
    
    public let readMoreLine = MaeumGaGymLine(lineColor: DSKitAsset.Colors.gray300.color, lineWidth: 64.0, lineHeight: 1.0)
        
    public init (
        text: agreeButtonTextType,
        font: UIFont? = UIFont.Pretendard.bodyMedium,
        type: Int? = 1,
        readMoreType: Bool? = false,
        chooseType: Bool? = false
    ) {
        super.init(frame: .zero)

        
        self.textLabel.text = text.message
        self.textLabel.font = font

        switch chooseType {
        case true:
            chooseLabel.isHidden = false
            break
        case false:
            chooseLabel.isHidden = true
            break
        default:
            break
        }
        
        switch readMoreType {
        case true:
            readMore.isHidden = false
            readMoreLine.isHidden = false
            break
        case false:
            readMore.isHidden = true
            readMoreLine.isHidden = true
            break
        default:
            break
        }

        switch type {
        case 1: 
            break
        default:
            chooseLabel.isHidden = false
        }
        
        setupUI()
        buttonTapped()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        self.addSubviews([iconImageView, textLabel, chooseLabel, readMoreLine, readMore])
        
        self.snp.makeConstraints {
            $0.width.equalTo(390.0)
            $0.height.equalTo(44.0)
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(28.0)
            $0.leading.equalToSuperview().offset(0.0)
            $0.centerY.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12.0)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20.0)
        }
        
        chooseLabel.snp.makeConstraints {
            $0.height.equalTo(20.0)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(textLabel.snp.trailing).offset(5.0)
        }
        
        readMoreLine.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(0.0)
            $0.bottom.equalToSuperview().offset(-13.0)
        }
        
        readMore.snp.makeConstraints {
            $0.width.equalTo(64.0)
            $0.height.equalToSuperview()
            $0.trailing.equalToSuperview().offset(0.0)
            $0.top.equalToSuperview().offset(0.0)
        }
    }
    
    public func buttonYesChecked() {
        checked = true
        iconImageView.image = DSKitAsset.Assets.yesCheck.image
    }
    
    public func buttonNoChecked() {
        checked = false
        iconImageView.image = DSKitAsset.Assets.noCheck.image
    }
    
    private func buttonTapped() {
        rx.tap
            .subscribe(onNext: { [self] in
                switch checked {
                case false:
                    buttonYesChecked()
                    break
                case true:
                    buttonNoChecked()
                    break
                }
            }).disposed(by: disposeBag)
        
        readMore.rx.tap
            .subscribe(onNext: {
                print("자세히 보기 클릭 됨")
            }).disposed(by: disposeBag)
    }
    
    public func editButtonType(text: String, readMoreType: Bool? = false) {
        
        self.textLabel.text = text
        
        switch readMoreType {
        case true:
            readMore.isHidden = false
            readMoreLine.isHidden = false
            break
        case false:
            readMore.isHidden = true
            readMoreLine.isHidden = true
            break
        default:
            break
        }
    }
}
