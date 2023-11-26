import UIKit

protocol PageManager: AnyObject {
  var page: Int { get set }
  var updatePage: ((Int) -> Void)? { get set }
}

extension PageManager {
  func setPage(offset: CGPoint, size: CGSize) {
    self.page = Int(floor(offset.y / size.height))
    self.updatePage?(self.page)
  }

  func setPage(_ page: Int) {
    self.page = page
    self.updatePage?(self.page)
  }
}
