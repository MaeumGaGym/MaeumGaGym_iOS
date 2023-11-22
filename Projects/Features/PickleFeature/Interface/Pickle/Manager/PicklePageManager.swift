import Foundation

final class PicklePageManager: PageManager {
    var page: Int = 0
    var updatePage: ((Int) -> Void)?
}
