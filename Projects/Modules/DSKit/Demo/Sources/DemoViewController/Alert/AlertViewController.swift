import UIKit
import SnapKit
import Then

public class AlertViewController: UIViewController {
    
    let alertView = AlertAppleMusic17View(title: "Added to Library", subtitle: nil, icon: .done)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        alertView.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        alertView.titleLabel?.textColor = .black
        alertView.backgroundColor = .black
        
        alertView.present(on: self.view)
    }
}
