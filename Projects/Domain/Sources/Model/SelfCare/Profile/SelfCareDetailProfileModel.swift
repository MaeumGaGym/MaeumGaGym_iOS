import UIKit

public struct SelfCareDetailProfileModel {
    public var userImage: UIImage
    public var userName: String
    public var userWakaTime: String
    public var userBageLevel: Int

    public init(userImage: UIImage, userName: String, userWakaTime: String, userBageLevel: Int) {
        self.userImage = userImage
        self.userName = userName
        self.userWakaTime = "\(userWakaTime)시간"
        self.userBageLevel = userBageLevel
    }
}
