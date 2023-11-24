import Foundation

public protocol PickleEvent {
    var shouldBatchUpdate: Bool { get set }
}

struct PicklePlayEvent: PickleEvent {
    public var shouldBatchUpdate: Bool = true
    let priority: Pickle.VideoPriority
    var didSelect: Bool = false
}

struct PicklePauseEvent: PickleEvent {
    public var shouldBatchUpdate: Bool = false
    let priority: Pickle.VideoPriority
    var didSelect: Bool = false
}
