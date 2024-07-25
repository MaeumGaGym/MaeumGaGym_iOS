import Foundation

import UIKit
//import DSKit

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
            UIImage(),
            UIImage(),
            UIImage(),
            UIImage()
        ])
    }
}

protocol DomainConvertible {
    associatedtype DomainType
    func toDomain() -> DomainType
}

public struct PoseRecommandDTO: Codable {
    let responses: [PoseRecommandPart]
}

public struct PoseRecommandPart: Codable {
    let category: String
    let poses: [PoseRecommandResponse]
}

public struct PoseRecommandResponse: Codable {
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

extension PoseRecommandDTO: DomainConvertible {
    public func toDomain() -> PoseRecommandModel {
        return .init(responses: responses.toDomain())
    }
}

extension PoseRecommandPart: DomainConvertible {
    public func toDomain() -> PoseRecommandPartModel {
        return .init(category: category, poses: poses.toDomain())
    }
}

extension PoseRecommandResponse: DomainConvertible {
    public func toDomain() -> PoseRecommandResponseModel {
        return .init(id: id, category: category, needMachine: needMachine, name: name, simplePart: simplePart, exactPart: exactPart, thumbnail: thumbnail)
    }
}


extension Array where Element: DomainConvertible {
    func toDomain() -> [Element.DomainType] {
        return self.map { $0.toDomain() }
    }
}

public struct PosePartDTO: Codable {
    let responses: [PosePartResponse]
}

public struct PosePartResponse: Codable {
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

extension PosePartDTO: DomainConvertible {
    public func toDomain() -> PosePartModel {
        return .init(responses: responses.toDomain())
    }
}

extension PosePartResponse: DomainConvertible {
    public func toDomain() -> PosePartResponseModel {
        return .init(id: id, category: category, needMachine: needMachine, name: name, simplePart: simplePart, exactPart: exactPart, thumbnail: thumbnail)
    }
}
