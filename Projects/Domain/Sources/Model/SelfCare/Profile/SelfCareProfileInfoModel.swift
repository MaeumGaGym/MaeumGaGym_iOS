import Foundation

public struct SelfCareProfileInfoModel {
    public var nickname: String
    public var profileImage: String?
    public var level: Int
    public var wakaTime: Int
    
    public init(nickname: String, profileImage: String? = nil, level: Int, wakaTime: Int) {
        self.nickname = nickname
        self.profileImage = profileImage
        self.level = level
        self.wakaTime = wakaTime
    }
}
