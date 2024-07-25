import UIKit

public struct PoseRecommandModel {
    public var responses: [PoseRecommandPartModel]
    
    public init(responses: [PoseRecommandPartModel]) {
        self.responses = responses
    }
}

public struct PoseRecommandPartModel {
    public var category: String
    public var poses: [PoseRecommandResponseModel]
    
    public init(category: String, poses: [PoseRecommandResponseModel]) {
        self.category = category
        self.poses = poses
    }
}

public struct PoseRecommandResponseModel {
    public var id: Int
    public var category: [String]
    public var needMachine: Bool
    public var name: String
    public var simplePart, exactPart: [String]
    public var thumbnail: String
    
    public init(id: Int, category: [String], needMachine: Bool, name: String, simplePart: [String], exactPart: [String], thumbnail: String) {
        self.id = id
        self.category = category
        self.needMachine = needMachine
        self.name = name
        self.simplePart = simplePart
        self.exactPart = exactPart
        self.thumbnail = thumbnail
    }
}
