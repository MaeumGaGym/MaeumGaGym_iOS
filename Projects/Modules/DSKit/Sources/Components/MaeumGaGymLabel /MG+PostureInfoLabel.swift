import UIKit

import SnapKit
import Then

import Core

open class MGPostureInfoLabel: BaseLabel {

    private var containerView = UIView()

    private var titleNumberLabel = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.textColor = DSKitAsset.Colors.gray200.color
        $0.font = UIFont.Pretendard.titleMedium
    }

    private var textLabel = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = .black
        $0.font = UIFont.Pretendard.bodyMedium
    }

    public init() {
        super.init(frame: .zero)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layout() {
        addSubviews([containerView])
        containerView.addSubviews([titleNumberLabel, textLabel])

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleNumberLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(52.0)
            $0.height.equalTo(32.0)
        }

        textLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(titleNumberLabel.snp.trailing)
        }
    }
}

public extension MGPostureInfoLabel {
    func setup(index: Int, text: String) {
        titleNumberLabel.text = "0\(index)"
        let lineCount = text.components(separatedBy: "\n").count
        textLabel.numberOfLines = lineCount
        textLabel.reloadInputViews()
        textLabel.text = text
    }
}
