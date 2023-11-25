import UIKit
import Core

public protocol PickleItem: ReuseIdentifier {
    var idx: String { get set }
    var url: URL? { get set }
    var isMuted: Bool { get set }
}


public struct PickleBaseItem: PickleItem {
    public var idx: String
    public var url: URL?
    public var isMuted: Bool
    
    public init(idx: String, url: URL?, isMuted: Bool) {
        self.idx = idx
        self.url = url
        self.isMuted = isMuted
    }
}
