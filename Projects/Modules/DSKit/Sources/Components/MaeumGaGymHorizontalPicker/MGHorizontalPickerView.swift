import UIKit
import SnapKit
import Then

open class HorizontalPickerView: UIView {
    private var pickerWidth = 50

    public var pickerSelectValue = 0

    public var isFirstLoad: Bool?

    private let levelValues: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    private var rotationAngle: CGFloat! = -90  * (.pi/180)

    private var changedLevelPicker = false

    public var delegate: HorizontalPickerViewDelegate?

    lazy var pickerView = UIPickerView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.transform = CGAffineTransform(rotationAngle: -90 * (.pi / 180))
    }

    private lazy var titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.textColor = .black
    }
    
    lazy var pickerSetLabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setPicker()
        pickerView.subviews[1].isHidden = true
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setPicker() {
        setUpLayout()
        self.backgroundColor = .white
        self.pickerView.delegate?.pickerView?(self.pickerView, didSelectRow: pickerSelectValue, inComponent: 0)
    }
    
    public override func layoutSubviews() {
        guard changedLevelPicker else {
            pickerSelectValue =  pickerSelectValue < 0 ? 0 : pickerSelectValue
            pickerSelectValue =  pickerSelectValue < levelValues.count ? levelValues.count : pickerSelectValue

            self.pickerView.selectRow(pickerSelectValue, inComponent: 0, animated: true)
            
            if self.frame.height < 110 {
                titleLabel.removeFromSuperview()
            }
            changedLevelPicker = true
            return
        }
    }
    
}
extension HorizontalPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           rowHeightForComponent component: Int
    ) -> CGFloat {
        return CGFloat(pickerWidth)
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           numberOfRowsInComponent component: Int
    ) -> Int {
        return levelValues.count
    }

    public func pickerView(_ pickerView: UIPickerView,
                           didSelectRow row: Int,
                           inComponent component: Int
    ) {
        delegate?.didLevelChanged(selectedLevel: row)
        guard let selectView = pickerView.view(forRow: row, forComponent: component) else {
            isFirstLoad = false
            return
        }
        
        let selectLabel = selectView.subviews[0] as! UILabel
        selectLabel.textColor = .black
        selectLabel.font  = UIFont.Pretendard.light32
        
        if let beforeView = pickerView.view(forRow: row - 1, forComponent: component) {
            let beforeLabel = beforeView.subviews[0] as! UILabel
            beforeLabel.font = UIFont.Pretendard.light32
            beforeLabel.textColor = .black
        }
        if let afterView = pickerView.view(forRow: row + 1, forComponent: component) {
            let afterLabel = afterView.subviews[0] as! UILabel
            afterLabel.font = UIFont.Pretendard.light32
            afterLabel.textColor = .black
        }
        
        guard let myBool = isFirstLoad else {
            isFirstLoad = false
            return
        }
        
        if !myBool {
            isFirstLoad = true
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           viewForRow row: Int,
                           forComponent component: Int,
                           reusing view: UIView?
    ) -> UIView {

        let pickerRow = UIView()
        pickerRow.frame = CGRect(x: 0, y: 0, width: pickerWidth, height: 32)
        
        lazy var rowLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.Pretendard.light32
            label.textAlignment = .center
            label.layer.cornerRadius = 15
            label.layer.masksToBounds = true
            label.backgroundColor = .white
            return label
        }()

        pickerRow.addSubview(rowLabel)
        rowLabel.snp.makeConstraints {
            $0.leading.equalTo(pickerRow.snp.leading).offset(8)
            $0.trailing.equalTo(pickerRow.snp.trailing).offset(-8)
            $0.height.equalTo(pickerRow.snp.height)
        }

        rowLabel.text = "\(levelValues[row])"
        pickerRow.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))

        guard let myBool = isFirstLoad else {
            return pickerRow
        }

        guard !myBool else {
            return pickerRow
        }
        
        guard let selectView = pickerView.view(forRow: pickerSelectValue, forComponent: component) else {
            return pickerRow
        }

        let selectLabel = selectView.subviews[0] as! UILabel
        selectLabel.textColor = .white
        selectLabel.font = UIFont.Pretendard.light32
        return pickerRow
    }
}
extension HorizontalPickerView {
    
    private func setUpLayout() {

        self.addSubview(pickerSetLabel)
        self.addSubview(pickerView)
        self.addSubview(titleLabel)

        pickerSetLabel.snp.makeConstraints {
            $0.height.equalTo(pickerWidth)
            $0.width.equalTo(self.snp.width)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
        pickerView.snp.makeConstraints {
            $0.height.equalTo(pickerSetLabel.snp.width)
            $0.width.equalTo(pickerSetLabel.snp.height)
            $0.centerX.equalTo(pickerSetLabel.snp.centerX)
            $0.centerY.equalTo(pickerSetLabel.snp.centerY)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(pickerSetLabel.snp.top)
        }
    }
}
