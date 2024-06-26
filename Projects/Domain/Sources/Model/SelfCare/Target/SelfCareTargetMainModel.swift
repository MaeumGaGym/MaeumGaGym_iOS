import UIKit

public struct SelfCareTargetMainModel {
    public var titleTextData: TargetTitleTextModel
    public var targetData: [TargetContentModel]

    public init(
        titleTextData: TargetTitleTextModel,
        targetData: [TargetContentModel]) {
        self.titleTextData = titleTextData
        self.targetData = targetData
    }
}

public struct TargetTitleTextModel {
    public var titleText: String
    public var infoText: String

    public init(titleText: String, infoText: String) {
        self.titleText = titleText
        self.infoText = infoText
    }
}

public struct TargetContentModel {
    public var targetTitle: String
    public var targetStartData: String
    public var targetEndData: String

    public init(targetTitle: String, targetStartData: String, targetEndData: String) {
        self.targetTitle = targetTitle
        self.targetStartData = targetStartData
        self.targetEndData = targetEndData
    }
}
