import UIKit

import SnapKit
import Then

import Core
import DSKit
import Domain
import MGLogger

public class MGTargetAlertView: UIViewController {

    public var clickDate: (String?) -> Void

    private let calendar = UICalendarView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 13
        $0.timeZone = .current
        $0.locale = .current
        $0.wantsDateDecorations = true
        $0.layer.shadow(color: .black, alpha: 0.25, x: 0, y: 4, blur: 4, spread: 0)
    }

    public init(
        clickDate: @escaping (String?) -> Void
    ) {
        self.clickDate = clickDate
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        view.backgroundColor = .clear
        attribute()
        layout()
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }

    private func attribute() {
        calendar.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
    }
    private func layout() {
        view.addSubviews([
            calendar
        ])

        calendar.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(390)
            $0.height.equalTo(348)
        }
    }

}

extension MGTargetAlertView: UICalendarSelectionSingleDateDelegate {
    public func dateSelection(
        _ selection: UICalendarSelectionSingleDate,
        didSelectDate dateComponents: DateComponents?
    ) {
        if let date = dateComponents {
            let fullDate = "\(date.year ?? 0)-\(date.month ?? 0)-\(date.day ?? 0)"
            let date = fullDate.changeDateFormatWithInput(input: .fullDate, type: .fullDateKorForCalendar)
            clickDate(date)
            self.dismiss(animated: true)
        } else {
            print("empty date")
        }
    }
}
