import Foundation

public struct PosePartModel {
    public var responses: [PosePartResponseModel]
    
    public init(responses: [PosePartResponseModel]) {
        self.responses = responses
    }
}

public struct PosePartResponseModel {
    public var id: Int
    public var category: [String]
    public var needMachine: Bool
    public var name: String
    public var simplePart, exactPart: [String]
    public var thumbnail: String

    init(id: Int, category: [String], needMachine: Bool, name: String, simplePart: [String], exactPart: [String], thumbnail: String) {
        self.id = id
        self.category = category
        self.needMachine = needMachine
        self.name = name
        self.simplePart = simplePart
        self.exactPart = exactPart
        self.thumbnail = thumbnail
    }
}

