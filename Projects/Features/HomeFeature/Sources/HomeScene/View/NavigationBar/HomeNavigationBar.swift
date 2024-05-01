import UIKit

import RxSwift
import RxCocoa

import Core
import DSKit

final class HomeNavigationBar: BaseView {

    public var rightButtonTap: ControlEvent<Void> {
         return rightButton.rx.tap
     }

    private let logoImageView = UIImageView().then {
        $0.image = DSKitAsset.Assets.mainLogo.image.withRenderingMode(.alwaysOriginal)
        $0.contentMode = .scaleToFill
    }

    private let rightButton = MGImageButton(image: DSKitAsset.Assets.settingActIcon.image)

    private lazy var rightItemsStackView = UIStackView(arrangedSubviews: [rightButton]).then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillEqually
    }
    
    override init(frame: CGRect) { super.init(frame: frame) }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func attribute() {
        self.backgroundColor = DSKitAsset.Colors.gray25.color
    }
    
    override func layout() {
        self.addSubviews([logoImageView, rightItemsStackView])

        self.snp.makeConstraints {
            $0.height.equalTo(42)
        }

        logoImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.height.equalTo(42)
        }

        rightItemsStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}

extension HomeNavigationBar {
    @discardableResult
    public func setRightButtonImage(image: UIImage) -> Self {
        self.rightButton.setImage(image, for: .normal)
        return self
    }
}
