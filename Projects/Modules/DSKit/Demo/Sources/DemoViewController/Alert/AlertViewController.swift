import UIKit
import SnapKit
import Then

public class AlertViewController: UIViewController {
    
    let alertView1 = MaeumGaGymAlertBarView(title: "링크가 복사되었어요.", subtitle: nil, icon: .done)
    let alertView2 = MaeumGaGymAlertBoxView(title: "알려주셔서 고마워요", subtitle: nil, icon: .done)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        alertView1.titleLabel?.font = UIFont.Pretendard.labelMedium
        alertView1.titleLabel?.textColor = .black
        alertView1.backgroundColor = .gray
        
        alertView2.titleLabel?.font = UIFont.Pretendard.labelMedium
        alertView2.titleLabel?.textColor = .black
        alertView2.backgroundColor = .gray
        
        alertView1.present(on: self.view)
        alertView2.present(on: self.view)
    }
}
