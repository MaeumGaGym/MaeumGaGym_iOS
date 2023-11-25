import UIKit

protocol PickleManager where Self: UICollectionViewDataSource {
  var itemManager: ItemManager { get set }
  var pageManager: PageManager { get set }
  var playerControl: PlayerControl { get set }
  var delegate: PickleManagerDelegate? { get set }

  func register(identifier: String)
  func send(event: PickleEvent)
}

extension PickleManager {
  typealias ReuseIdentifier = Pickle.ReuseIdentifier
}
