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
            "5"
        ]
            .enumerated()
            .map { idx, url -> PickleItems in
                return .init(
                    idx: "\(idx)",
                    url: self.createLocalUrl(for: url, ofType: "mp4"), isMuted: false,
                    name: "\(idx) 영상",
                    userName: "박준하",
                    mainTitle: "마음가짐 테스트 영상",
                    subTitle: "오늘도 열심히 헬스하러 헬스장을 가보는 것은 어떻까요?",
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
