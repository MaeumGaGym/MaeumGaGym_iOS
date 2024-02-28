import UIKit

public struct SelfCareTargetDetailModel {
    public var titleTextData: String
    public var startDateData: String
    public var endDateData: String
    public var textData: String

    public init(titleTextData: String,
                startDateData: String,
                endDateData: String,
                textData: String
    ) {
        self.titleTextData = titleTextData
        self.startDateData = startDateData
        self.endDateData = endDateData
        self.textData = textData
    }
}
