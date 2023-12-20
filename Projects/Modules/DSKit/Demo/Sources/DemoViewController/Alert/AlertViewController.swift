import UIKit
import SnapKit
import Then

public class AlertViewController: UIViewController {
    
    let alertView1 = MaeumGaGymAlertBarView(title: "Added to Library", subtitle: nil, icon: .done)
    let alertView2 = MaeumGaGymAlertBoxView(title: "asdf", subtitle: nil, icon: .heart)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        alertView1.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        alertView1.titleLabel?.textColor = .white
        alertView1.backgroundColor = .black
        
        alertView1.present(on: self.view)
    }
}
