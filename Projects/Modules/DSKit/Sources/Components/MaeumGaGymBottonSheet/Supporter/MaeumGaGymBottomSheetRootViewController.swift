import UIKit
import SnapKit

public final class MaeumGaGymBottomSheetRootViewController: UIViewController {
    
    public let tableView = UITableView()
    private var isFirstTimeAppear = true
    
    override public func loadView() {
        view = tableView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = DSKitAsset.Colors.gray900.color
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: true)
        }
        if isFirstTimeAppear, let nav = navigationController {
            nav.navigationBar.prefersLargeTitles = true
            let topOffset = nav.isNavigationBarHidden ? 0 : nav.navigationBar.frame.height
            tableView.setContentOffset(CGPoint(x: 0, y: -topOffset), animated: false)
            isFirstTimeAppear = false
        }
    }
}
