import UIKit

import RxSwift
import RxCocoa

import Core
import DSKit

import MGNetworks

final class RoutineNavigationBarBar: UIView {

    public var leftButtonTap: ControlEvent<Void> {
         return leftButton.rx.tap
     }

    private let leftButton = MGImageButton(image: DSKitAsset.Assets.blackLeftBarArrow.image)

    private lazy var leftItemsStackView = UIStackView(arrangedSubviews: [leftButton]).then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillEqually
    }
    
    private lazy var leftTextLabel = MGLabel(font: UIFont.Pretendard.labelLarge, textColor: .black, isCenter: false, numberOfLineCount: 1)

    init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RoutineNavigationBarBar {
    @discardableResult
    public func setLeftButtonImage(image: UIImage) -> Self {
        self.leftButton.setImage(image, for: .normal)
        return self
    }

    public func setLeftText(text: String)  {
        self.leftTextLabel.changeText(text: text)
    }
}

// MARK: - UI & Layout
extension RoutineNavigationBarBar {
    private func setUI() {
        self.backgroundColor = .clear
    }

    private func setLayout() {
        self.addSubviews([leftItemsStackView, leftTextLabel])

        leftButton.snp.makeConstraints {
            $0.width.height.equalTo(24.0)
        }

        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        leftItemsStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalToSuperview().offset(20)
        }

        leftTextLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14.0)
            $0.leading.equalTo(leftItemsStackView.snp.trailing).offset(24.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }
    }
}
