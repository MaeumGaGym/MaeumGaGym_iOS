import UIKit

import RxSwift
import RxCocoa

import Core
import DSKit

import MGNetworks

final public class SelfCareProfileNavigationBar: UIView {

    private var leftText: String?

    public var leftButtonTap: ControlEvent<Void> {
        return leftButton.rx.tap
    }

    private let leftButton = MGImageButton(image: DSKitAsset.Assets.leftBarArrow.image.withTintColor(.black))

    private lazy var leftLabel = MGLabel(
        text: leftText,
        font: UIFont.Pretendard.labelLarge,
        textColor: .black
    )

    private lazy var leftItemsStackView = UIStackView(arrangedSubviews: [leftButton, leftLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 24
    }

    public init(
        leftText: String? = nil
    ) {
        super.init(frame: .zero)
        self.leftText = leftText
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
            $0.leading.equalToSuperview().inset(10.0)
        }
    }
}
