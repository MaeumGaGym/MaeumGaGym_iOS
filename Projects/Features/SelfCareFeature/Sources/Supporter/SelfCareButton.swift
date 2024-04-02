import UIKit

import SnapKit
import Then

import Core
import DSKit

public class SelfCareButton: BaseButton {

    private var containerView = UIView()

    private var buttonImage = UIImageView()
    
    private var buttonLabel = MGLabel(font: UIFont.Pretendard.labelLarge,
                                      isCenter: false,
                                      numberOfLineCount: 1
    )

    public init (
        type: SelfCareButtonType
    ) {
        super.init(frame: .zero)
        setup(type: type)
        typeLayout(type: type)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layout() {
        addSubview(containerView)

        containerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(17.0)
        }
    }

    public override func attribute() {
        layer.cornerRadius = 8.0
    }
}

private extension SelfCareButton {
    func typeLayout(type: SelfCareButtonType) {
        switch type.buttonImage {
        case nil:
            containerView.addSubviews([buttonLabel])

            buttonLabel.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(24.0)
                $0.trailing.equalToSuperview()
            }

            buttonLabel.sizeToFit()
            containerView.snp.remakeConstraints {
                $0.width.equalTo(buttonLabel.frame.width)
                $0.centerX.equalToSuperview()
                $0.top.bottom.equalToSuperview().inset(17.0)
            }

        default:
            containerView.addSubviews([buttonImage, buttonLabel])

            buttonImage.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.width.height.equalTo(24.0)
            }

            buttonLabel.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.leading.equalTo(buttonImage.snp.trailing).offset(8.0)
                $0.trailing.equalToSuperview()
                $0.height.equalTo(24.0)
            }

            buttonLabel.sizeToFit()
            containerView.snp.remakeConstraints {
                $0.width.equalTo(type.width)
                $0.centerX.equalToSuperview()
                $0.top.bottom.equalToSuperview().inset(17.0)
            }
        }
    }

    func setup(type: SelfCareButtonType) {
        switch type.buttonImage {
        case nil:
            buttonImage.isHidden = true
        default:
            buttonImage.image = type.buttonImage
        }

        buttonLabel.changeText(text: type.text)
        buttonLabel.changeTextColor(color: type.textColor)
        backgroundColor = type.backgroundColor
    }
}
