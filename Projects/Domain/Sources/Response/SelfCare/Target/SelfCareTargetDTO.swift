import Foundation

public struct SelfCareTargetDTOElement: Decodable {
    let id: Int
    let title: String
    let content: String
    let startDate: String
    let endDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, content
        case startDate = "start_date"
        case endDate = "end_date"
    }
}

public extension SelfCareTargetDTOElement {
    func toDomain() -> TargetContentModel {
        return .init(id: id, targetTitle: title, content: content, targetStartDate: startDate, targetEndDate: endDate)
    }
}

public struct SelfCareTargetDTO: Decodable {
    let targetList: [SelfCareTargetDTOElement]
    
    enum CodingKeys: String, CodingKey {
        case targetList = "purpose_list"
    }
    
}

public extension SelfCareTargetDTO {
    func toDomain() -> SelfCareTargetMainModel {
        return .init(targetList: targetList.map { $0.toDomain() })
    }
}
