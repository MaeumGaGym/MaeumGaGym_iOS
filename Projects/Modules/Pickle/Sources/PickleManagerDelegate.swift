import Foundation

protocol PickleManagerDelegate: ItemManagerDelegate {
    func recive(event: PickleEvent)
    func currentPage(page: Int)
}
