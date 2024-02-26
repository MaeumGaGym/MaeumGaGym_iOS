import UIKit
import Core
import MGLogger

public enum AlertType: String, CaseIterable {
    case caveat
    case disappeared
}

public class AlertViewControllerTableViewController: BaseDesignSystemTableViewController<AlertType> {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        designSystems = AlertType.allCases
    }

    public override func showDetailViewController(for designSystem: AlertType) {
        switch designSystem {
        case .caveat:
            MGLogger.verbose("caveat Alert")
            self.navigationController?.pushVC(DSCaveatAlertViewController.self)
        case .disappeared:
            MGLogger.verbose("Auth Button")
            self.navigationController?.pushVC(DSDisappearAlertViewController.self)
        }
    }
}
