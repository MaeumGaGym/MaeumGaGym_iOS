import UIKit
import SnapKit
import RxFlow
import RxCocoa
import RxSwift
import Core

public class HomeViewController: UIViewController, Stepper {

    public var steps = PublishRelay<Step>()

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        self.view.backgroundColor = .systemBackground
    }
}
