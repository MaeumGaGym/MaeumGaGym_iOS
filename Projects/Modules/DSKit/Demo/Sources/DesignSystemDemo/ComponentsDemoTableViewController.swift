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
    case slider
    case horizontalPicker
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
            self.navigationController?.pushVC(DSTextFieldViewController.self)
        case .label:
            MGLogger.verbose("label")
            self.navigationController?.pushVC(LabelTableViewController.self)
        case .line:
            MGLogger.verbose("line")
            self.navigationController?.pushVC(DSLineViewController.self)
        case .profile:
            MGLogger.verbose("profile")
            self.navigationController?.pushVC(DSProfileViewController.self)
        case .alert:
            MGLogger.verbose("alert")
            self.navigationController?.pushVC(AlertViewControllerTableViewController.self)
        case .bottomSheet:
            MGLogger.verbose("bottomSheet")
            self.navigationController?.pushVC(DSBottomSheetViewController.self)
        case .emptyView:
            MGLogger.verbose("emptyView")
            self.navigationController?.pushVC(DSEmptyViewController.self)
        case .pagingTabBar:
            MGLogger.verbose("pagingTabBar")
            self.navigationController?.pushVC(DSPagingTabBarViewController.self)
        case .banner:
            MGLogger.verbose("Banner")
            self.navigationController?.pushVC(DSBannerViewController.self)
        case .slider:
            MGLogger.verbose("Slider")
            self.navigationController?.pushVC(DSSliderViewController.self)
        case .horizontalPicker:
            MGLogger.verbose("horizontalPicker")
            self.navigationController?.pushVC(DSHorizontalPickerViewController.self)
        }
    }
}
