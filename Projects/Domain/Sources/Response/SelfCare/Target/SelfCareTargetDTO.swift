import Foundation

public struct SelfCareTargetDTOElement: Decodable {
    let id: Int
    let title: String
    let contenet: String
    let startDate: String
    let endData: String
}

public extension SelfCareTargetDTOElement {
    func toDomain() -> TargetContentModel {
        return .init(id: id, targetTitle: title, content: contenet, targetStartData: startDate, targetEndData: endData)
    }
}

public typealias SelfCareTargetDTO = [SelfCareTargetDTOElement]

public extension SelfCareTargetDTO {
    func toDomain() -> SelfCareTargetMainModel {
        return .init(
            titleTextData: .init(titleText: "목표", infoText: "나만의 목표를 세워보세요"),
            targetData: self.map { $0.toDomain() }
        )
    }
}
