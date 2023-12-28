import UIKit
import SnapKit
import Then

public class ToggleViewController: UIViewController {
    
    let toggleView = MaeumGaGymToggleView(width: 430.0, height: 793.0)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }

    func layout() {
        [
            toggleView
        ].forEach { view.addSubview($0) }
        
        toggleView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(101.0)
            $0.width.equalTo(430.0)
            $0.height.equalTo(845.0)
        }

    }
}
