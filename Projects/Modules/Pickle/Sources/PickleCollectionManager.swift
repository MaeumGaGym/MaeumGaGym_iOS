import UIKit
import Core

final class PickleCollectionManager: NSObject {
    
    private enum Constant {
        static let sectionCount = 1
    }
    
    var itemManager: ItemManager
    var pageManager: PageManager
    var playerControl: PlayerControl
    private var reuseIdentifiers: [String] = []
    weak var delegate: PickleManagerDelegate?
    
    init(itemManager: ItemManager, pageManager: PageManager, playerControl: PlayerControl) {
        self.itemManager = itemManager
        self.pageManager = pageManager
        self.playerControl = playerControl
        super.init()
        
        self.itemManager.delegate = self
        self.playerControl.delegate = self
        self.pageManager.updatePage = { [weak self] page in
            self?.playerControl.play(priority: .low)
            self?.delegate?.currentPage(page: page)
        }
    }
}


extension PickleCollectionManager: PickleManager {
    func register(identifier: String) {
        self.reuseIdentifiers.append(identifier)
    }
    
    func send(event: PickleEvent) {
        switch event {
        case let playEvent as PicklePlayEvent:
            self.playerControl.play(priority: playEvent.priority)
        case let pauseEvent as PicklePauseEvent:
            self.playerControl.pause(priority: pauseEvent.priority)
        default:
            self.delegate?.recive(event: event)
            break
        }
    }
}


extension PickleCollectionManager: PlayerControlDelegate {
    func play(priority: Pickle.VideoPriority, didSelect: Bool) {
        var event = PicklePlayEvent(priority: priority)
        event.didSelect = didSelect
        self.delegate?.recive(event: event)
    }
    
    func pause(priority: Pickle.VideoPriority, didSelect: Bool) {
        var event = PicklePauseEvent(priority: priority)
        event.didSelect = didSelect
        self.delegate?.recive(event: event)
    }
}


extension PickleCollectionManager: ItemManagerDelegate {
    func reloadAll() {
        self.delegate?.reloadAll()
    }
    
    func reload(indexPaths: [IndexPath]) {
        self.delegate?.reload(indexPaths: indexPaths)
    }
    
    func insert(indexPaths: [IndexPath]) {
        self.delegate?.insert(indexPaths: indexPaths)
    }
    
    func delete(indexPaths: [IndexPath]) {
        self.delegate?.delete(indexPaths: indexPaths)
        self.playerControl.play(priority: .low)
    }
}


extension PickleCollectionManager: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constant.sectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemManager.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = self.itemManager.getItem(at: indexPath) else {
            return UICollectionViewCell()
        }
        
        if self.reuseIdentifiers.contains(item.identifier),
           let itemCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: item.identifier, for: indexPath
           ) as? PickleCollectionViewCell {
            itemCell.configure(item: item)
            return itemCell
        }
        
        guard let baseCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReuseIdentifier.defualt.rawValue, for: indexPath
        ) as? PickleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        baseCell.configure(item: item)
        return baseCell
    }
}
