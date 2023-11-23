import UIKit
import PickleFeature
import PickleFeatureInterface
import AVKit
import SnapKit
import Then

public class PickleViewController: UIViewController {
    
    private let reelsView: PickleView = {
        let view = PickleView.view()
        view.register(PickleCell.self, itemType: PickleItems.self)
        return view
    }()
    
    private let contentView = UIStackView().then {
        $0.axis = .vertical
    }
    
    private let deleteButton = UIButton().then {
        $0.setTitle("Delete", for: .normal)
    }
    
    private let moveButton = UIButton().then {
        $0.setTitle("Move", for: .normal)
    }
    
    private let insertButton = UIButton().then {
        $0.setTitle("Insert", for: .normal)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
        let items = [
            "1",
            "2",
            "3",
            "4",
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
    
    // MARK: - Setup
    
    private func setup() {
        view.addSubview(reelsView)
        view.addSubview(contentView)
        contentView.addArrangedSubview(deleteButton)
        contentView.addArrangedSubview(moveButton)
        contentView.addArrangedSubview(insertButton)
        
        reelsView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.right.equalTo(view).offset(-15)
        }
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        moveButton.addTarget(self, action: #selector(moveButtonTapped), for: .touchUpInside)
        insertButton.addTarget(self, action: #selector(insertButtonTapped), for: .touchUpInside)
    }
    
    @objc private func deleteButtonTapped() {
        var idxs = Set<String>()
        idxs.insert("2")
        reelsView.delete(idxs: idxs)
    }
    
    @objc private func moveButtonTapped() {
        reelsView.moveToPage(0, animated: true)
    }
    
    @objc private func insertButtonTapped() {
        let items: [PickleItems] = [
            PickleItems(idx: "11", url: createLocalUrl(for: "6", ofType: "mov"), isMuted: false, name: "이재하"),
        ]
        reelsView.insert(items: items)
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
