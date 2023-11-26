import Foundation

protocol PlayerControlDelegate: AnyObject {
    func play(priority: Pickle.VideoPriority, didSelect: Bool)
    func pause(priority: Pickle.VideoPriority, didSelect: Bool)
}
