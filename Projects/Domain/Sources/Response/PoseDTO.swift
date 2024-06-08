import Foundation

import DSKit

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

struct PoseDetailDTO: Decodable {
    let needMachine: Bool
    let category: [String]
    let simpleName, exactName: String
    let thumbnail: String
    let video: String
    let simplePart, exactPart, startPose, exerciseWay: [String]
    let breatheWay, caution: [String]

    enum CodingKeys: String, CodingKey {
        case needMachine = "need_machine"
        case category
        case simpleName = "simple_name"
        case exactName = "exact_name"
        case thumbnail, video
        case simplePart = "simple_part"
        case exactPart = "exact_part"
        case startPose = "start_pose"
        case exerciseWay = "exercise_way"
        case breatheWay = "breathe_way"
        case caution
    }
}

extension PoseDetailDTO {
    func toDomain() -> PostureDetailModel_temporary {
        return .init(needMachine: needMachine, category: category, simpleName: simpleName, exactName: exactName, thumbnail: thumbnail, video: video, simplePart: simplePart, exactPart: exactPart, startPose: startPose, exerciseWay: exerciseWay, breatheWay: breatheWay, caution: caution, pickleImage: [
            DSKitAsset.Assets.posturePickleTest1.image,
            DSKitAsset.Assets.posturePickleTest2.image,
            DSKitAsset.Assets.posturePickleTest3.image,
            DSKitAsset.Assets.posturePickleTest4.image
        ])
    }
}

struct PoseRecommandDTO: Decodable {
    let poses: PoseRecommandPart
}

struct PoseRecommandPart: Decodable {
    let 어깨, 복근, 등, 가슴, 팔: PoseRecommandPartResponse
}

struct PoseRecommandPartResponse: Decodable {
    let responses: [PoseRecommandResponse]
}

struct PoseRecommandResponse: Decodable {
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

extension PoseRecommandDTO {
    
}
