import UIKit

import DSKit
import Core
import MGLogger

public enum LabelType: String, CaseIterable {
    case mgLabel
    case tagLabel
    case postureInfoLabel
}

public class LabelTableViewController: BaseDesignSystemTableViewController<LabelType> {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        designSystems = LabelType.allCases
    }
    
    public override func showDetailViewController(for designSystem: LabelType) {
        switch designSystem {
        case .mgLabel:
            MGLogger.verbose("MGLabel")
            self.navigationController?.pushVC(DSLabelVC.self)
        case .tagLabel:
            MGLogger.verbose("TagLabel")
            self.navigationController?.pushVC(DSTagLabelVC.self)
        case .postureInfoLabel:
            MGLogger.verbose("PostureInfoLabel")
            self.navigationController?.pushVC(DSPostureInfoLabelVC.self)
        }
    }
}
