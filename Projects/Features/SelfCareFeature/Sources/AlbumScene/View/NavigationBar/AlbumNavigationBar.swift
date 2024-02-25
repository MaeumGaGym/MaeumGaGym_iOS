import UIKit

import RxSwift
import RxCocoa

import Core
import DSKit

final public class AlbumNavigationBar: UIView {

    public var leftButtonTap: ControlEvent<Void> {
        return leftButton.rx.tap
    }

    private let leftButton = MGImageButton(image: DSKitAsset.Assets.arrowLeft.image)

    private let leftLabel = UILabel().then {
        $0.font = UIFont.Pretendard.titleMedium
        $0.text = "사진 선택"
        $0.textColor = .white
    }

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
