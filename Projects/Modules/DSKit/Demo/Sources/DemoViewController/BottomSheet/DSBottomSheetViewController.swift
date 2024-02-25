import UIKit
import DSKit

struct BottomSheetItem {
    let icon: UIImage
    let title: String
}

public class DSBottomSheetViewController: UIViewController {

    private let bottomSheetViewController: MGBottomSheetViewController = {
        if #available(iOS 11.0, *) {
            return MGBottomSheetViewController(type: .plain)
        } else {
            return MGBottomSheetViewController(type: .plain)
        }
    }()
    
    private var bottomSheetItems: [BottomSheetItem] = []

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        bottomSheetItems = [
             BottomSheetItem(icon: DSKitAsset.Assets.heart.image, title: "수정"),
             BottomSheetItem(icon: DSKitAsset.Assets.heart.image, title: "삭제")
         ]

        bottomSheetViewController.bottomSheetDelegate = self

        let tableView = bottomSheetViewController.tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            MGBottomSheetIconCell.self,
            forCellReuseIdentifier: MGBottomSheetIconCell.identifier
        )
        addChild(bottomSheetViewController)
        bottomSheetViewController.show(in: view, initialState: .collapsed)
        bottomSheetViewController.didMove(toParent: self)

        let bottomSheetView = bottomSheetViewController.view
        bottomSheetView?.layer.shadowColor = UIColor.black.cgColor
        bottomSheetView?.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        bottomSheetView?.layer.shadowRadius = 5
        bottomSheetView?.layer.shadowOpacity = 0.5

        let hideButton = MGButton(titleText: "Hide BottomSheet")

         hideButton.addTarget(self, action: #selector(hideBottomSheet), for: .touchUpInside)

         view.addSubview(hideButton)
         hideButton.snp.makeConstraints {
             $0.centerX.equalTo(view.snp.centerX)
             $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
         }
    }

    @objc private func expand() {
        bottomSheetViewController.state = .partiallyExpanded
    }
    
    @objc private func hideBottomSheet() {
        bottomSheetViewController.hideBottomSheet {
            print("BottomSheet 숨김")
        }
    }
}

extension DSBottomSheetViewController: MGBottomSheetViewDelegate {

    public func didMove(to percentage: Float) {
//        bottomSheetViewController.rootViewController.title = String(format: "didMove to %.1f", percentage)
    }
}

extension DSBottomSheetViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bottomSheetItems.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MGBottomSheetIconCell.identifier,
            for: indexPath
        ) as! MGBottomSheetIconCell

        let item = bottomSheetItems[indexPath.row]
        cell.iconImage.image = item.icon
        cell.mainTitle.text = item.title

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
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52.0
    }
}
