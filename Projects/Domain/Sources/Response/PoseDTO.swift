import Foundation

import DSKit

public struct PostureAllDTO: Decodable {
    public let responses: [PostureAllResponse]
}

public struct PostureAllResponse: Decodable {
    public let id: Int
    public let category: [String]
    public let needMachine: Bool
    public let name: String
    public let simplePart, exactPart: [String]
    public let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case id, category
        case needMachine = "need_machine"
        case name
        case simplePart = "simple_part"
        case exactPart = "exact_part"
        case thumbnail
    }
}

public extension PostureAllDTO {
    public func toDomain() -> PostureAllModel {
        let dataModels = responses.map { response in
            PostureAllDataModel(
                id: response.id,
                category: response.category,
                needMachine: response.needMachine,
                name: response.name,
                simplePart: response.simplePart,
                exactPart: response.exactPart,
                thumbnail: response.thumbnail
            )
        }
        return PostureAllModel(responses: dataModels)
    }
}

public struct PoseDetailDTO: Decodable {
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

public extension PoseDetailDTO {
    func toDomain() -> PostureDetailModel {
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
