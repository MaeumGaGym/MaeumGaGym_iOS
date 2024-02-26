import UIKit
import SnapKit
import Then
import DSKit

public class DSHorizontalPickerViewController: UIViewController {
    
    private lazy var hPickerView: HorizontalPickerView = {
        let view = HorizontalPickerView()
        view.pickerSelectValue = 0
        view.delegate = self

        return view
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        view.backgroundColor = .white
    }

}

extension DSHorizontalPickerViewController: HorizontalPickerViewDelegate {
    
    public func didLevelChanged(selectedLevel: Int) {
        print("변경된 값은?:\(selectedLevel)")
    }
    
}

extension DSHorizontalPickerViewController {
    
    func setUpLayout() {
        
        view.addSubview(hPickerView)
        hPickerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.center.equalToSuperview()
            $0.height.equalTo(120)
        }
    }
}
