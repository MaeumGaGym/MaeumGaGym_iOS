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

//public struct SelfCareNicknameDTO: Decodable {
//    public let nickname: String
//}
//
//public extension SelfCareNicknameDTO {
//    func toDomain() -> SelfCareModifyProfileModel {
//        return .init(name: nickname)
//    }
//}

public struct SelfCareProfileInfoDTO: Codable {
    let nickname: String
    let profileImage: String?
    let level: Int
    let wakaTime: Int
    
    enum CodingKeys: String, CodingKey {
        case nickname, level
        case profileImage = "profile_image"
        case wakaTime = "total_wakatime"
    }
}

extension SelfCareProfileInfoDTO {
    public func toDomain() -> SelfCareProfileInfoModel {
        return .init(nickname: nickname, profileImage: profileImage, level: level, wakaTime: wakaTime)
    }
}
