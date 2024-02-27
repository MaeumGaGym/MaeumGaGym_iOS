import UIKit

import RxSwift
import RxCocoa

import Core
import DSKit

import MGNetworks

final public class SelfCareProfileNavigationBar: UIView {

    public var leftButtonTap: ControlEvent<Void> {
        return leftButton.rx.tap
    }

    private let leftButton = MGImageButton(image: SelfCareResourcesService.Assets.leftArrow.withTintColor(.black))

    private let leftLabel = MGLabel(text: SelfCareResourcesService.Title.myProfileEdit,
        font: UIFont.Pretendard.labelLarge,
                                            textColor: .black
    )

    private lazy var leftItemsStackView = UIStackView(arrangedSubviews: [leftButton, leftLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.distribution = .fillEqually
    }

    public init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SelfCareProfileNavigationBar {
    func setUI() {
        self.backgroundColor = .white
    }

    func setLayout() {
        self.addSubview(leftItemsStackView)

        self.snp.makeConstraints {
            $0.height.equalTo(48.0)
        }

        leftItemsStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(-10.0)
        }
    }
}
