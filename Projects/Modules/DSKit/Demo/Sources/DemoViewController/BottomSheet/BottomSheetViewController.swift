import UIKit

public class BottomSheetViewController: UIViewController {

    private let bottomSheetViewController : MaeumGaGymBottomSheetViewController = {
        if #available(iOS 11.0, *) {
            return MaeumGaGymBottomSheetViewController(type: .navigation(title: "ㅅ"))
        } else {
            return MaeumGaGymBottomSheetViewController(type: .plain)
        }
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        bottomSheetViewController.bottomSheetDelegate = self

        let tableView = bottomSheetViewController.tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

        addChild(bottomSheetViewController)
        bottomSheetViewController.show(in: view, initial: .collapsed)
        bottomSheetViewController.didMove(toParent: self)

        let bottomSheetView = bottomSheetViewController.view
        bottomSheetView?.layer.shadowColor = UIColor.black.cgColor
        bottomSheetView?.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        bottomSheetView?.layer.shadowRadius = 5
        bottomSheetView?.layer.shadowOpacity = 0.5
    }

    @objc private func expand() {
        bottomSheetViewController.state = .partiallyExpanded
    }
}

extension BottomSheetViewController : MaeumGaGymBottomSheetViewDelegate {

    public func didMove(to percentage: Float) {
//        bottomSheetViewController.rootViewController.title = String(format: "didMove to %.1f", percentage)
    }
}

extension BottomSheetViewController : UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)"
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if bottomSheetViewController.isNavigationBarHidden {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let vc = UIViewController()
        let cell = tableView.cellForRow(at: indexPath)
        vc.title = cell?.textLabel?.text
        vc.view.backgroundColor = .white
        bottomSheetViewController.show(vc, sender: self)
    }
}
