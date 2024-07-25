import UIKit

public struct SelfCareMyRoutineDetailModel {
    public var routineTitleData: SelfCareRoutineModel
    public var routinesData: [SelfCareMyRoutineDetailExerciseModel]

    public init(routineTitleData: SelfCareRoutineModel, routinesData: [SelfCareMyRoutineDetailExerciseModel]) {
        self.routineTitleData = routineTitleData
        self.routinesData = routinesData
    }
}

public struct SelfCareMyRoutineDetailExerciseModel {
    public var exericseImage: UIImage
    public var exerciseTitle: String
    public var exerciseCount: Int
    public var exerciseSet: Int

    public init(exericseImage: UIImage, exerciseTitle: String, exerciseCount: Int, exerciseSet: Int) {
        self.exericseImage = exericseImage
        self.exerciseTitle = exerciseTitle
        self.exerciseCount = exerciseCount
        self.exerciseSet = exerciseSet
    }
}
