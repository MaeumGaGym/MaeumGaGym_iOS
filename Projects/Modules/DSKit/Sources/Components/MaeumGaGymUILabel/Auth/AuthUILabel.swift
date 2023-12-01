import UIKit
import Then
import SnapKit
import Core
import RxSwift
import RxCocoa

open class MaeumGaGymAuthLabel: UILabel {
    
    private let textLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.backgroundColor = .clear
    }
    
    private let disposeBag = DisposeBag()
    
    public init(
        text: String,
        font: UIFont? = UIFont.Pretendard.titleMedium,
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
            switch font {
            case UIFont.Pretendard.titleLarge:
                snp.makeConstraints {
                    $0.height.equalTo(48)
                }
            case UIFont.Pretendard.bodyMedium:
                snp.makeConstraints {
                    $0.height.equalTo(20)
                }
            default:
                break
            }
        }
            
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        addSubview(textLabel)

        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
