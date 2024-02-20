import UIKit

import SnapKit
import Then

import Core
import DSKit

public class TimerPickerView: BaseView {
    private var pickerWidth: Double = 75.0
    public var isFirstLoad: Bool?

    public var pickerSelectValue = 0

    private let hourValues: [Int] = [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10,
                                     11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]

    private let minuteValues: [Int] = [00, 01, 02, 03, 04, 05, 06, 07, 08, 09,
                                       10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,
                                       24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
                                       38, 39, 40, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59]

    private let secondValues: [Int] = [00, 01, 02, 03, 04, 05, 06, 07, 08, 09,
                                       10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                                       21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
                                       33, 34, 35, 36, 37, 38, 39, 40, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59]

    private var rotationAngle: CGFloat! = -90  * (.pi/180)

    lazy var pickerView = UIPickerView().then {
        $0.transform = CGAffineTransform(rotationAngle: 0)
    }

    private lazy var titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.Pretendard.light
        $0.textColor = .black
    }

    lazy var pickerSetLabel = UILabel()

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layout() {
        addSubviews([pickerView])

        pickerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(43.5)
            $0.top.equalToSuperview().offset(14.0)
            $0.bottom.equalToSuperview().inset(10.0)
        }
    }

    public override func attribute() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
}

extension TimerPickerView: UIPickerViewDelegate {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    public func pickerView(_ pickerView: UIPickerView,
                           titleForRow row: Int,
                           forComponent component: Int
    ) -> String? {
        switch component {
        case 0:
            return "\(hourValues[row])"
        case 1:
            return "\(minuteValues[row])"
        case 2:
            return "\(secondValues[row])"
        default:
            return ""
        }
    }

    public func pickerView(_ pickerView: UIPickerView,
                           rowHeightForComponent component: Int
    ) -> CGFloat {
        return 48.0
    }

    public func pickerView(_ pickerView: UIPickerView,
                           viewForRow row: Int,
                           forComponent component: Int,
                           reusing view: UIView?
    ) -> UIView {

        let pickerRow = UIView()
        pickerRow.frame = CGRect(x: 0, y: 0, width: pickerWidth, height: 128.0)

        lazy var rowLabel = UILabel().then {
            $0.textColor = .black
            $0.font = UIFont.Pretendard.light
            $0.textAlignment = .center
            $0.layer.masksToBounds = true
            $0.backgroundColor = .white
        }

        pickerRow.addSubview(rowLabel)
        rowLabel.snp.makeConstraints {
            $0.center.equalTo(pickerRow.snp.center) // 레이블을 UIView의 중앙에 위치시킴
            $0.width.equalTo(pickerRow.snp.width)
            $0.height.equalTo(48) // 레이블의 높이를 48로 설정
        }

        switch component {
        case 0:
            rowLabel.text = "\(hourValues[row])"
        case 1:
            rowLabel.text = "\(minuteValues[row])"
        case 2:
            rowLabel.text = "\(secondValues[row])"
        default:
            rowLabel.text = ""
        }

        pickerRow.transform = CGAffineTransform(rotationAngle: 0)

        guard let myBool = isFirstLoad else {
            return pickerRow
        }

        guard !myBool else {
            return pickerRow
        }

        guard let selectView = pickerView.view(forRow: pickerSelectValue,
                                               forComponent: component
        ) else {
            return pickerRow
        }

        let selectLabel = selectView.subviews[0] as? UILabel
        selectLabel?.textColor = .black
        selectLabel?.font = UIFont.Pretendard.light
        return pickerRow
    }

    public func pickerView(_ pickerView: UIPickerView,
                           widthForComponent component: Int
    ) -> CGFloat {
        switch component {
        case 0:
            return pickerWidth + 38.5
        case 1:
            return pickerWidth + 38.5
        case 2:
            return pickerWidth
        default:
            return 0
        }
    }
}

extension TimerPickerView: UIPickerViewDataSource {

    public func pickerView(_ pickerView: UIPickerView,
                           numberOfRowsInComponent component: Int
    ) -> Int {
        switch component {
        case 0:
            return hourValues.count
        case 1:
            return minuteValues.count
        case 2:
            return secondValues.count
        default:
            return 0
        }
    }
}
