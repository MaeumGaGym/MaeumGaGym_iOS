import UIKit
import AVKit
import SnapKit
import Then
import DSKit
import Pickle

public class PickleViewController: UIViewController {
    
    private let reelsView: PickleView = {
        let view = PickleView.view()
        view.register(PickleCell.self, itemType: PickleItems.self)
        return view
    }()
    
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
                    url: self.createLocalUrl(for: url, ofType: "mov"),
                    isMuted: false,
                    name: "\(idx) 영상"
                )
            }
        
        self.reelsView.reloadAll(items: items)
    }
        
    private func setup() {
        view.addSubview(reelsView)
        
        reelsView.snp.makeConstraints {
            $0.edges.equalTo(view)
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
