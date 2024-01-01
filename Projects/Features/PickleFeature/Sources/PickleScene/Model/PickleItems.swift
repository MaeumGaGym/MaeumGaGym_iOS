import Foundation
import PickleFeatureInterface
import Pickle

public struct PickleItems: PickleItem {
    public var idx: String
    public var url: URL?
    public var isMuted: Bool
    public var name: String
    
    public var userName: String
    public var mainTitle: String
    public var subTitle: String?
    
    public var hartCount: Int?
    public var commentCount: Int?
    
    public init(idx: String, url: URL? = nil, isMuted: Bool, name: String, userName: String, mainTitle: String, subTitle: String?, hartCount: Int?, commentCount: Int?) {
        self.idx = idx
        self.url = url
        self.isMuted = isMuted
        self.name = name
        self.userName = userName
        self.mainTitle = mainTitle
        self.subTitle = subTitle
        self.hartCount = hartCount
        self.commentCount = commentCount
    }
}
