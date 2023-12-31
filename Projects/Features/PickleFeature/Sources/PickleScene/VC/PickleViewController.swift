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
