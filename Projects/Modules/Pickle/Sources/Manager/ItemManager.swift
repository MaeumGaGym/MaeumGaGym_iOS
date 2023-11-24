import Foundation

public protocol ItemManager: AnyObject {

  var items: [PickleItem] { get set }
  var delegate: ItemManagerDelegate? { get set }

  func reloadAll(items: [PickleItem])
  func reload(items: [PickleItem], isOverlap: Bool)
  func insert(items: [PickleItem])
  func delete(idxs: Set<String>, isOverlap: Bool)
}

public extension ItemManager {

  var count: Int {
    self.items.count
  }

  func setItem(at indexPath: IndexPath, item: PickleItem) {
    guard self.items.count > indexPath.item, indexPath.item >= 0 else {
      return
    }
    self.items[indexPath.item] = item
  }

  func getItem(at indexPath: IndexPath) -> PickleItem? {
    guard self.items.count > indexPath.item, indexPath.item >= 0 else {
      return nil
    }
    return self.items[indexPath.item]
  }

  func getItem(at page: Int) -> PickleItem? {
    guard self.items.count > page, page >= 0 else {
      return nil
    }
    return self.items[page]
  }
}
