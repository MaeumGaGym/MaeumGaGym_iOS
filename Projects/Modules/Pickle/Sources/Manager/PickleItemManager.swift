import Foundation

final class PickleItemManager {

  var items: [PickleItem] = []
  weak var delegate: ItemManagerDelegate?

  init() {
      
  }
}

extension PickleItemManager: ItemManager {
  func reloadAll(items: [PickleItem]) {
    self.items = items
    self.delegate?.reloadAll()
  }

  func reload(items: [PickleItem], isOverlap: Bool) {
    guard !self.items.isEmpty else {
      assertionFailure("Item Empty")
      return
    }

    var indexPaths: [IndexPath] = []
    var reloadItems = items
    let updateItems = self.items.enumerated().map { originalIndex, originalItem -> PickleItem in
      if let reload = reloadItems.enumerated().first(where: { $0.element.idx == originalItem.idx }) {
        if isOverlap {
          reloadItems.remove(at: reload.offset)
        }
        indexPaths.append(.init(item: originalIndex, section: 0))
        return reload.element
      }
      return originalItem
    }
    self.items = updateItems
    self.delegate?.reload(indexPaths: indexPaths)
  }

  func insert(items: [PickleItem]) {
    let startIndex = self.items.count
    let endIndex = self.items.count + items.count
    let indexPaths = (startIndex ..< endIndex).map { index -> IndexPath in
      return .init(item: index, section: 0)

    }
    self.items.append(contentsOf: items)
    self.delegate?.insert(indexPaths: indexPaths)
  }

  func delete(idxs: Set<String>, isOverlap: Bool) {
    var indexPaths: [IndexPath] = []
    var deleteItems = items
    let updateItems = self.items.enumerated().compactMap { index, originalItem -> PickleItem? in
      if let delete = idxs.enumerated().first(where: { $0.element == originalItem.idx }) {
        if isOverlap {
          deleteItems.remove(at: delete.offset)
        }
        indexPaths.append(.init(item: index, section: 0))
        return nil
      }
      return originalItem
    }

    self.items = updateItems
    self.delegate?.delete(indexPaths: indexPaths)
  }
}
