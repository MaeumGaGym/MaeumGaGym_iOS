import UIKit
import Core
import CSLogger
import DSKit

public enum DesignSystemType: String, CaseIterable {
    case button
    case textField
    case label
    case line
    case profile
    case alert
    case bottomSheet
    case emptyView
    case pagingTabBar
}

public class ComponentsDemoTableViewController: BaseDesignSystemTableViewController<DesignSystemType> {

    override public func viewDidLoad() {
        super.viewDidLoad()
        designSystems = DesignSystemType.allCases
    }

    public override func showDetailViewController(for designSystem: DesignSystemType) {
        switch designSystem {
        case .button:
            Logger.verbose("Button")
            self.navigationController?.pushVC(ButtonTableViewController.self)
        case .textField:
            Logger.verbose("textField")
            self.navigationController?.pushVC(TextFieldViewController.self)
        case .label:
            Logger.verbose("label")
            self.navigationController?.pushVC(LabelViewController.self)
        case .line:
            Logger.verbose("line")
            self.navigationController?.pushVC(LineViewController.self)
        case .profile:
            Logger.verbose("profile")
            self.navigationController?.pushVC(ProfileViewController.self)
        case .alert:
            Logger.verbose("alert")
            self.navigationController?.pushVC(AlertViewController.self)
        case .bottomSheet:
            Logger.verbose("bottomSheet")
            self.navigationController?.pushVC(BottomSheetViewController.self)
        case .emptyView:
            Logger.verbose("emptyView")
            self.navigationController?.pushVC(EmptyViewController.self)
        case .pagingTabBar:
            Logger.verbose("pagingTabBar")
            self.navigationController?.pushVC(PagingTabBarViewController.self)
        }
    }
}
