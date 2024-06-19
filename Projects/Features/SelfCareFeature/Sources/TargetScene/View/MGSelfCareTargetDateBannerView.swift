import UIKit

import SnapKit
import Then

import Core
import DSKit
import Domain

public class MGSelfCareTargetDateBannerView: BaseView {

    private let lineView = MGLine(lineColor: .blue500, lineWidth: 2).then {
        $0.layer.cornerRadius = 1
    }
    private let typeLabel = MGLabel(font: UIFont.Pretendard.bodyMedium, textColor: .gray600)
    private let dateLabel = MGLabel(font: UIFont.Pretendard.bodyMedium, textColor: .gray600)

    public func setup(
        dateText: String
    ) {
        self.dateLabel.changeText(text: dateText.changeDateFormatWithInput(input: .fullDate, type: .fullDateKor))
    }

    public init(
        typeText: String
    ) {
        super.init(frame: .zero)
        self.typeLabel.text = typeText
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layout() {
        self.addSubviews([
            lineView,
            typeLabel,
            dateLabel
        ])

        self.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        lineView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        typeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(lineView.snp.trailing).offset(10)
        }
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(typeLabel.snp.leading).offset(48)
        }
    }

}
