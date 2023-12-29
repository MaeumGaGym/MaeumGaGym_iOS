import UIKit
import AVKit
import SnapKit
import Then
import DSKit
import Pickle

struct BottomSheetItem {
    let icon: UIImage
    let title: String
}

public class PickleViewController: UIViewController {
    
    private let reelsView: PickleView = {
        let view = PickleView.view()
        view.register(PickleCell.self, itemType: PickleItems.self)
        return view
    }()
    
    var aButton = UIButton().then {
        $0.backgroundColor = .red
    }
    
    private let bottomSheetViewController : MaeumGaGymBottomSheetViewController = {
        if #available(iOS 11.0, *) {
            return MaeumGaGymBottomSheetViewController(type: .plain)
        } else {
            return MaeumGaGymBottomSheetViewController(type: .plain)
        }
    }()
    
    private var bottomSheetItems: [BottomSheetItem] = []
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()

        let items = [
            "1",
            "2",
            "3",
            "4",
            "7",
            "7",
            "7",
            "7",
            "7",
            "7",
            "5",
        ]
            .enumerated()
            .map { idx, url -> PickleItems in
                return .init(
                    idx: "\(idx)",
                    url: self.createLocalUrl(for: url, ofType: "mov"), isMuted: false,
                    name: "\(idx) 영상",
                    userName: "박준하",
                    mainTitle: "상괘한 날씨의 오늘",
                    subTitle: "날씨가 정말 좋네요. 오늘은 정말 산책하기 좋은날인 것 같아요!",
                    hartCount: 10,
                    commentCount: 5
                )
            }
        
        self.reelsView.reloadAll(items: items)
        
        
        bottomSheetItems = [
             BottomSheetItem(icon: DSKitAsset.Assets.pencilIcon.image, title: "수정"),
             BottomSheetItem(icon: DSKitAsset.Assets.deleteIcon.image, title: "삭제")
         ]
        
        bottomSheetViewController.bottomSheetDelegate = self

        let tableView = bottomSheetViewController.tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MaeumGaGymBottomSheetIconCell.self, forCellReuseIdentifier: MaeumGaGymBottomSheetIconCell.identifier)
    }
        
    private func setup() {
        view.addSubview(reelsView)
        
        view.addSubview(aButton)
        
        reelsView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        aButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(100)
        }
        
        aButton.rx.tap.bind {
            if let tabBarController = self.tabBarController {
                tabBarController.addChild(self.bottomSheetViewController)
                self.bottomSheetViewController.show(in: tabBarController.view, initialState: .collapsed)
                self.bottomSheetViewController.didMove(toParent: tabBarController)
            }

            let bottomSheetView = self.bottomSheetViewController.view
            bottomSheetView?.layer.shadowColor = UIColor.black.cgColor
            bottomSheetView?.layer.shadowOffset = CGSize(width: 0, height: 5.0)
            bottomSheetView?.layer.shadowRadius = 5
            bottomSheetView?.layer.shadowOpacity = 0.5
        }
    }
    
    private func createLocalUrl(for filename: String, ofType: String) -> URL? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(filename).\(ofType)")
        guard fileManager.fileExists(atPath: url.path) else {
            guard let video = NSDataAsset(name: filename)  else { return nil }
            fileManager.createFile(atPath: url.path, contents: video.data, attributes: nil)
            return url
        }
        return url
    }
}

extension PickleViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bottomSheetItems.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaeumGaGymBottomSheetIconCell.identifier, for: indexPath) as! MaeumGaGymBottomSheetIconCell

        let item = bottomSheetItems[indexPath.row]
        cell.iconImage.image = item.icon
        cell.title.text = item.title

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

extension PickleViewController: MaeumGaGymBottomSheetViewDelegate {

    public func didMove(to percentage: Float) {
    }
}
