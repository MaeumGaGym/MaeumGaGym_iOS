import UIKit

public struct SelfCareDetailProfileModel {
    public var userImage: String?
    public var userName: String
    public var userWakaTime: Int
    public var userBageLevel: Int

    public init(userImage: String?, userName: String, userWakaTime: Int, userBageLevel: Int) {
        self.userImage = userImage
        self.userName = userName
        self.userWakaTime = userWakaTime
        self.userBageLevel = userBageLevel
    }
}
