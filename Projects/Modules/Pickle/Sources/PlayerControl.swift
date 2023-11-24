import Foundation

protocol PlayerControl: AnyObject {
    
    typealias Priority = Pickle.VideoPriority
    
    var isPlay: Bool { get set }
    var delegate: PlayerControlDelegate? { get set }
    
    func play(priority: Priority)
    func pause(priority: Priority)
    func toggle(priority: Priority, didSelect: Bool)
    func refresh()
}
