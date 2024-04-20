import UIKit
import HomeFeatureInterface

import RxSwift
import RxCocoa

import Core
import DSKit

import MGNetworks

final class MetronomeNavigationBar: BaseView {

    public var rightButtonTap: ControlEvent<Void> {
        return rightButton.rx.tap
    }

    private let rightButton = MGImageButton(image: HomeResourcesService.Assets.rightNVButton)

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
        self.backgroundColor = .white
    }
    
    override func layout() {
        self.addSubview(rightItemsStackView)

        self.snp.makeConstraints {
            $0.height.equalTo(42)
        }

        rightItemsStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
