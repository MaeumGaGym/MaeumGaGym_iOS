import UIKit
import Foundation
import SnapKit
import Then
import Core

public class StatusLayoutView: BaseView {
    
    private let imageView = UIImageView().then {
        $0.adjustsImageSizeForAccessibilityContentSizeCategory = true
        $0.contentMode = .scaleAspectFill
        $0.tintColor = .black

    }

    private var messageLabel = MGLabel(font: .systemFont(ofSize: 16.0, weight: .semibold),
                                       textColor: .red,
                                       isCenter: true,
                                       numberOfLineCount: 0
    ).then {
        $0.sizeToFit()
    }
    
    public init(message: String, image: UIImage) {
        super.init(frame: .zero)
        self.setupUI(message: message, image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layout() {
        super.layout()
        
        self.addSubviews([imageView, messageLabel])

        self.imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-80.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(80.0)
        }

        self.messageLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(40.0)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupUI(message: String, image: UIImage) {
        imageView.image = image
        messageLabel.text = message
    }
}
