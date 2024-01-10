import UIKit
import SnapKit
import Then

public class RedViewController: UIViewController {
    
    private lazy var textView = UIView().then {
        $0.backgroundColor = .black
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        layout()
    }
    
    func layout() {
        view.addSubview(textView)
        
        textView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(100)
        }
    }
}

public class OrangeViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
    }
}

public class YellowViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
    }
}

public class GreenViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
    }
}

public class BlueViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
}

public class PurpleViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
    }
}

public class BrownViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
    }
}

public class BlackViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
    }
}

public class WhiteViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
