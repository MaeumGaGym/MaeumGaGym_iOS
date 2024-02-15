import UIKit
import SnapKit
import Then

public class DSSliderViewController: UIViewController {
    
    let slider = MGSlider()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(slider)
        slider.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(300.0)
        }
    }
}
