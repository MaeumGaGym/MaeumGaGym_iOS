import UIKit
import HomeFeatureInterface

import RxSwift
import RxCocoa

import Core
import DSKit

import MGNetworks

final class MetronomeNavigationBar: UIView {

    public var rightButtonTap: ControlEvent<Void> {
        return rightButton.rx.tap
    }

    private let rightButton = MGImageButton(image: HomeResourcesService.Assets.rightNVButton)

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

extension MetronomeNavigationBar {
    private func setUI() {
        self.backgroundColor = .white
    }

    private func setLayout() {
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
