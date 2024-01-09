import UIKit
import DSKit
import Core
import CSLogger

public enum ButtonType: String, CaseIterable {
    case agree
    case auth
    case certification
    case icon
    case check
    case timer
    case toggle
}

public class ButtonTableViewController: BaseDesignSystemTableViewController<ButtonType> {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        designSystems = ButtonType.allCases
    }

    public override func showDetailViewController(for designSystem: ButtonType) {
        switch designSystem {
        case .agree:
            Logger.verbose("Agree Button")
            self.navigationController?.pushVC(DSAgreeButtonVC.self)
        case .auth:
            Logger.verbose("Auth Button")
            self.navigationController?.pushVC(DSAuthButtonVC.self)
        case .certification:
            Logger.verbose("Certification Button")
            self.navigationController?.pushVC(DSCertificationButtonVC.self)
        case .icon:
            Logger.verbose("Icon Button")
            self.navigationController?.pushVC(DSIconButtonVC.self)
        case .check:
            Logger.verbose("Check Button")
            self.navigationController?.pushVC(DSCheckButtonVC.self)
        case .timer:
            Logger.verbose("Timer Button")
            self.navigationController?.pushVC(DSTimerButtonVC.self)
        case .toggle:
            Logger.verbose("Toggle Button")
            self.navigationController?.pushVC(DSToggleButtonVC.self)
        }
    }
}
