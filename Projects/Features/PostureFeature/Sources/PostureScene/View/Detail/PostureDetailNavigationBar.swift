import UIKit

import RxSwift
import RxCocoa

import Core
import DSKit

final class PostureDetailNavigationBar: BaseView {

    public var leftButtonTap: ControlEvent<Void> {
         return leftButton.rx.tap
     }

    private let leftButton = MGImageButton(image: DSKitAsset.Assets.blackLeftBarArrow.image)

    private lazy var leftItemsStackView = UIStackView(arrangedSubviews: [leftButton]).then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillEqually
    }

    override init(frame: CGRect) { super.init(frame: frame) }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func attribute() {
        self.backgroundColor = .clear
    }

    public override func layout() {
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

extension PostureDetailNavigationBar {
    @discardableResult
    public func setLeftButtonImage(image: UIImage) -> Self {
        self.leftButton.setImage(image, for: .normal)
        return self
    }
}
