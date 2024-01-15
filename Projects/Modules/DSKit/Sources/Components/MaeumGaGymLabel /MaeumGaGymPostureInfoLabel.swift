import UIKit
import SnapKit
import Then
import Core

open class MaeumGaGymPostureInfoLabel: BaseLabel {
    private var titleNumberLabel = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.backgroundColor = .clear
        $0.textColor = DSKitAsset.Colors.gray200.color
        $0.font = UIFont.Pretendard.titleMedium
    }
    private var textLabel = UILabel().then {
        $0.textAlignment = .left
        $0.backgroundColor = .clear
        $0.textColor = .black
        $0.font = UIFont.Pretendard.bodyMedium
    }
    
    public init(
        titleNumber: String,
        text: String,
        numberOfLines: Int? = 1
    ) {
        super.init(frame: .zero)
        self.textLabel.numberOfLines = numberOfLines ?? 1
        self.titleNumberLabel.text = titleNumber
        self.textLabel.text = text
        
        addViews()
        setupViews(lines: numberOfLines ?? 1)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.addSubview(titleNumberLabel)
        self.addSubview(textLabel)

    }
    
    private func setupViews(lines: Int) {
        switch lines {
        case 1:
            self.snp.makeConstraints {
                $0.height.equalTo(32.0)
            }
            titleNumberLabel.snp.makeConstraints {
                $0.height.equalTo(32.0)
            }
            textLabel.snp.makeConstraints {
                $0.height.equalTo(32.0)
            }
        case 2:
            self.snp.makeConstraints {
                $0.height.equalTo(52.0)
            }
            titleNumberLabel.snp.makeConstraints {
                $0.height.equalTo(32.0)
            }
            textLabel.snp.makeConstraints {
                $0.height.equalTo(52.0)
            }
        default:
            break
        }
        
        titleNumberLabel.snp.makeConstraints {
            $0.width.equalTo(52.0)
            $0.top.leading.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.leading.equalTo(titleNumberLabel.snp.trailing)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    public func updateData(textNum: String,text: String, textcolor: UIColor? = DSKitAsset.Colors.blue500.color, backgroundColor: UIColor? = DSKitAsset.Colors.gray50.color, font: UIFont? = UIFont.Pretendard.labelMedium, numberOfLines: Int? = 1) {
        self.titleNumberLabel.text = textNum
        self.textLabel.text = text
        self.textLabel.textColor = textcolor
        self.backgroundColor = backgroundColor
        self.textLabel.font = font
        
        addViews()
        setupViews(lines: numberOfLines ?? 1)
    }
}
