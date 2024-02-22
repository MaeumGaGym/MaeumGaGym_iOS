import UIKit

public struct SelfCareProfileModel {
    public var userImage: UIImage
    public var userName: String
    public var userTimer: String
    public var userBage: UIImage

    public init(userImage: UIImage, userName: String, userTimer: Int, userBage: UIImage) {
        self.userImage = userImage
        self.userName = userName
        self.userTimer = "\(userTimer)시간"
        self.userBage = userBage
    }
}
