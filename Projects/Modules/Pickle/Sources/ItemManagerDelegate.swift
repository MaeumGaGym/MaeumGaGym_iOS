import Foundation

public protocol ItemManagerDelegate: AnyObject {
  func reloadAll()
  func reload(indexPaths: [IndexPath])
  func insert(indexPaths: [IndexPath])
  func delete(indexPaths: [IndexPath])
}
