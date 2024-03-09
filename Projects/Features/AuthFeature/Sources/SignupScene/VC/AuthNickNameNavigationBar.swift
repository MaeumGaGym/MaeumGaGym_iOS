import UIKit

import RxSwift
import RxCocoa

import Core
import DSKit

import MGNetworks

final class AuthNickNameNavigationBar: UIView {

    public var leftButtonTap: ControlEvent<Void> {
         return leftButton.rx.tap
    }

    private let leftButton = MGImageButton(image: AuthResourcesService.Assets.leftArrow)

    private lazy var leftItemsStackView = UIStackView(arrangedSubviews: [leftButton]).then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillEqually
    }

    init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthNickNameNavigationBar {
    @discardableResult
    public func setLeftButtonImage(image: UIImage) -> Self {
        self.leftButton.setImage(image, for: .normal)
        return self
    }
}

// MARK: - UI & Layout
extension AuthNickNameNavigationBar {
    private func setUI() {
        self.backgroundColor = .clear
    }

    private func setLayout() {
        self.addSubviews([leftItemsStackView])

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
    }
}
