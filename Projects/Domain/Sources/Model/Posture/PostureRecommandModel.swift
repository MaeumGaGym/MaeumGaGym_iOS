import UIKit

public struct PoseRecommandModel {
    public var poses: PoseRecommandPartModel
    
    public init(poses: PoseRecommandPartModel) {
        self.poses = poses
    }
}

public struct PoseRecommandPartModel {
    public var 어깨, 복근, 등, 가슴, 팔: PoseRecommandPartResponseModel
    
    public init(어깨: PoseRecommandPartResponseModel, 복근: PoseRecommandPartResponseModel, 등: PoseRecommandPartResponseModel, 가슴: PoseRecommandPartResponseModel, 팔: PoseRecommandPartResponseModel) {
        self.어깨 = 어깨
        self.복근 = 복근
        self.등 = 등
        self.가슴 = 가슴
        self.팔 = 팔
    }
}

public struct PoseRecommandPartResponseModel {
    public var responses: [PoseRecommandResponseModel]
    
    public init(responses: [PoseRecommandResponseModel]) {
        self.responses = responses
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
