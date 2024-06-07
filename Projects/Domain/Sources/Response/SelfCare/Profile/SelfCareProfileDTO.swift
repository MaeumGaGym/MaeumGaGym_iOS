import Foundation
import UIKit

public struct SelfCareProfileDTO: Decodable {
    public let nickName: String
    public let profileImage: String?
    public let userWakaTime: Int
    public let userBageLevel: Int
    
    enum CodingKeys: String, CodingKey {
        case nickName = "nickname"
        case profileImage = "profile_image"
        case userWakaTime = "total_wakatime"
        case userBageLevel = "level"
    }
    
}

public extension SelfCareProfileDTO {
    func toDomain() -> SelfCareDetailProfileModel {
        return .init(
            userImage: profileImage,
            userName: nickName,
            userWakaTime: userWakaTime,
            userBageLevel: userBageLevel
        )
    }
}
