import UIKit

import RxSwift
import RxCocoa

import Core
import DSKit

import MGNetworks

final class PostureMainNavigationBar: UIView {

    public var rightButtonTap: ControlEvent<Void> {
         return rightButton.rx.tap
     }

    private let rightButton = MGImageButton(image: PostureResourcesService.Assets.blackSearchActIcon)

    private lazy var rightItemsStackView = UIStackView(arrangedSubviews: [rightButton]).then {
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

extension PostureMainNavigationBar {
    @discardableResult
    public func setRightButtonImage(image: UIImage) -> Self {
        self.rightButton.setImage(image, for: .normal)
        return self
    }
}

// MARK: - UI & Layout
extension PostureMainNavigationBar {
    private func setUI() {
        self.backgroundColor = .clear
    }

    private func setLayout() {
        self.addSubviews([rightItemsStackView])

        self.snp.makeConstraints {
            $0.height.equalTo(42)
        }

        rightItemsStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
