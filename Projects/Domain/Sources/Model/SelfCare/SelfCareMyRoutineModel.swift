import UIKit

public struct SelfCareMyRoutineModel {
    public var titleTextData: SelfCareMyRoutineTextModel
    public var myRoutineData: [SelfCareRoutineModel]
    
    public init(titleTextData: SelfCareMyRoutineTextModel, myRoutineData: [SelfCareRoutineModel]) {
        self.titleTextData = titleTextData
        self.myRoutineData = myRoutineData
    }
}

public struct SelfCareMyRoutineTextModel {
    public var titleText: String
    public var infoText: String

    public init(titleText: String, infoText: String) {
        self.titleText = titleText
        self.infoText = infoText
    }
}

public struct SelfCareRoutineModel {
    public var routineNameText: String
    public var usingState: Bool
    public var sharingState: Bool

    public init(routineNameText: String, usingState: Bool, sharingState: Bool) {
        self.routineNameText = routineNameText
        self.usingState = usingState
        self.sharingState = sharingState
    }
}
