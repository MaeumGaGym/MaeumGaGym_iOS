import UIKit
import Then
import SnapKit
import Core
import RxSwift
import RxCocoa

open class MGLabel: BaseLabel {
        
    private var textLabel = UILabel().then {
        $0.textAlignment = .center
        $0.backgroundColor = .clear
    }
    
    public init(
        text: String,
        font: UIFont? = UIFont.Pretendard.titleLarge,
        textColor: UIColor? = .black,
        isCenter: Bool? = true,
        numberOfLineCount: Int = 1
    ) {
        super.init(frame: .zero)
        
        setupUI(text: text,
                font: font,
                textColor: textColor,
                isCencter: isCenter ?? true,
                numberOfLineCount: numberOfLineCount
        )
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(text: String, font: UIFont?, textColor: UIColor?, isCencter: Bool, numberOfLineCount: Int) {
        
        if isCencter == true {
            textLabel.textAlignment = .center
        } else {
            textLabel.textAlignment = .left
        }
        
        textLabel.text = text
        textLabel.textColor = textColor
  
        if let font = font {
            textLabel.font = font
        }
        
        textLabel.numberOfLines = numberOfLineCount
    }
    
    public override func layout() {
        super.layout()
        
        self.addSubview(textLabel)

        self.textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.snp.makeConstraints {
            switch textLabel.font {
            case UIFont.Pretendard.titleLarge:
                $0.height.equalTo(48)
            case UIFont.Pretendard.bodyMedium:
                $0.height.equalTo(50)
            case UIFont.Pretendard.bodyMedium2:
                $0.height.equalTo(20)
                $0.width.equalTo(280.0)
            case UIFont.Pretendard.light:
                $0.height.equalTo(64.0)
            case UIFont.Pretendard.bodyLarge:
                $0.height.equalTo(24.0)
            case UIFont.Pretendard.titleMedium:
                $0.height.equalTo(32.0)
            case UIFont.Pretendard.labelMedium:
                $0.height.equalTo(20.0)
            default:
                break
            }
        }
    }
}
