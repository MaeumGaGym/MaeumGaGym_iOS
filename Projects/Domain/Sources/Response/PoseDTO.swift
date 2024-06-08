import Foundation

struct PostureAllDTO: Decodable {
    let responses: [PostureAllResponse]
}

struct PostureAllResponse: Decodable {
    let id: Int
    let category: [String]
    let needMachine: Bool
    let name: String
    let simplePart, exactPart: [String]
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case id, category
        case needMachine = "need_machine"
        case name
        case simplePart = "simple_part"
        case exactPart = "exact_part"
        case thumbnail
    }
}

extension PostureAllDTO {
//    func toDomain() -> SelfCareDetailProfileModel {
//        return .init(
//            userImage: profileImage,
//            userName: nickName,
//            userWakaTime: userWakaTime,
//            userBageLevel: userBageLevel
//        )
//    }
}
