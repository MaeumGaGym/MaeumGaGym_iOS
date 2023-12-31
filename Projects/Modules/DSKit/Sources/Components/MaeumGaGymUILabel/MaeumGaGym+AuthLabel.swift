import UIKit
import Then
import SnapKit
import Core
import RxSwift
import RxCocoa

open class MaeumGaGymLabel: UILabel {
    
    private let disposeBag = DisposeBag()
    
    private let textLabel = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.backgroundColor = .clear
    }
    
    public init(
        text: String,
        font: UIFont? = UIFont.Pretendard.titleLarge,
        textColor: UIColor? = .black
    ) {
        super.init(frame: .zero)
        
        setupUI(text: text, font: font, textColor: textColor)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(text: String, font: UIFont?, textColor: UIColor?) {
        textLabel.text = text
        textLabel.textColor = textColor
  
        if let font = font {
            textLabel.font = font
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(textLabel)

        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        snp.makeConstraints {
            switch textLabel.font {
            case UIFont.Pretendard.titleLarge:
                $0.height.equalTo(48)
            case UIFont.Pretendard.bodyMedium:
                $0.height.equalTo(50)
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
