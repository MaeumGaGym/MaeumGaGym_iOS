import UIKit

import SnapKit
import Then

import RxSwift
import RxCocoa

import Core
import DSKit
import Domain

public class MGDateSelectView: BaseView {

    public var dateButtonTap: ControlEvent<Void> {
         return dateSelectButton.rx.tap
     }

    private let todayDate = Date()

    private var typeColor: UIColor {
        dateSelectButton.isSelected ? .blue500 : .black
    }
    private var dateButtonBgColor: UIColor {
        dateSelectButton.isSelected ? .blue50 : .gray25
    }
    private var dateButtonBdColor: CGColor {
        dateSelectButton.isSelected ? UIColor.blue100.cgColor : UIColor.gray50.cgColor
    }

    private let typeLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.Pretendard.bodyMedium
    }
    private var dateSelectButton = UIButton(type: .custom).then {
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.Pretendard.bodyLarge
        $0.contentHorizontalAlignment = .leading
        $0.titleEdgeInsets = .init(top: 0, left: 12, bottom: 0, right: 0)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
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
    public func setupDate(
        date: String? = nil
    ) {
        self.dateSelectButton.setTitle(date, for: .normal)
    }
    
    public func setup(
        selcect: Bool? = false
    ) {
        self.dateSelectButton.isSelected = selcect!
        self.attribute()
    }
    public override func attribute() {
        typeLabel.textColor = typeColor
        dateSelectButton.backgroundColor = dateButtonBgColor
        dateSelectButton.layer.borderColor = dateButtonBdColor
    }
    public override func layout() {
        self.addSubviews([
            typeLabel,
            dateSelectButton
        ])

        self.snp.makeConstraints {
            $0.height.equalTo(76)
        }
        typeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        dateSelectButton.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}
