import Foundation
import PickleFeatureInterface
import Pickle

public struct PickleItems: PickleItem {
    public var idx: String
    public var url: URL?
    public var isMuted: Bool
    public var name: String
    
    public init(idx: String, url: URL? = nil, isMuted: Bool, name: String) {
        self.idx = idx
        self.url = url
        self.isMuted = isMuted
        self.name = name
    }
}
