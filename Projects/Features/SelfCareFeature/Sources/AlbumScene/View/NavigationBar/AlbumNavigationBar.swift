import UIKit

import RxSwift
import RxCocoa

import Core
import DSKit

import MGNetworks

final public class AlbumNavigationBar: UIView {

    public var leftButtonTap: ControlEvent<Void> {
        return leftButton.rx.tap
    }

    private let leftButton = MGImageButton(image: SelfCareResourcesService.Assets.leftArrow)

    private let leftLabel = MGLabel(text: SelfCareResourcesService.Title.selectPicture,
        font: UIFont.Pretendard.titleMedium,
                                            textColor: .white
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

private extension AlbumNavigationBar {
    func setUI() {
        self.backgroundColor = .black
    }

    func setLayout() {
        self.addSubview(leftItemsStackView)

        self.snp.makeConstraints {
            $0.height.equalTo(48.0)
        }

        leftItemsStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
}
