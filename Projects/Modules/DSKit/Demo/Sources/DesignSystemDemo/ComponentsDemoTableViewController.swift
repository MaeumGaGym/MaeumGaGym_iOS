import UIKit
import Core
import MGLogger
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
    case banner
}

public class ComponentsDemoTableViewController: BaseDesignSystemTableViewController<DesignSystemType> {

    override public func viewDidLoad() {
        super.viewDidLoad()
        designSystems = DesignSystemType.allCases
    }

    public override func showDetailViewController(for designSystem: DesignSystemType) {
        switch designSystem {
        case .button:
            MGLogger.verbose("Button")
            self.navigationController?.pushVC(ButtonTableViewController.self)
        case .textField:
            MGLogger.verbose("textField")
            self.navigationController?.pushVC(TextFieldViewController.self)
        case .label:
            MGLogger.verbose("label")
            self.navigationController?.pushVC(LabelViewController.self)
        case .line:
            MGLogger.verbose("line")
            self.navigationController?.pushVC(LineViewController.self)
        case .profile:
            MGLogger.verbose("profile")
            self.navigationController?.pushVC(ProfileViewController.self)
        case .alert:
            MGLogger.verbose("alert")
            self.navigationController?.pushVC(AlertViewController.self)
        case .bottomSheet:
            MGLogger.verbose("bottomSheet")
            self.navigationController?.pushVC(BottomSheetViewController.self)
        case .emptyView:
            MGLogger.verbose("emptyView")
            self.navigationController?.pushVC(EmptyViewController.self)
        case .pagingTabBar:
            MGLogger.verbose("pagingTabBar")
            self.navigationController?.pushVC(PagingTabBarViewController.self)
        case .banner:
            MGLogger.verbose("Banner")
            self.navigationController?.pushVC(BannerViewController.self)
        }
    }
}
