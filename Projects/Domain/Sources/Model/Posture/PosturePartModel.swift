import UIKit

public struct PosturePartModel {
    public var exerciseType: [PosturePartExerciseTypeModel]
    public var allExerciseData: [PosturePartExerciseModel]
    public var bodyExerciseData: [PosturePartExerciseModel]
    public var machineExerciseData: [PosturePartExerciseModel]

    public init(exerciseType: [PosturePartExerciseTypeModel], allExerciseData: [PosturePartExerciseModel], bodyExerciseData: [PosturePartExerciseModel], machineExerciseData: [PosturePartExerciseModel]) {
        self.exerciseType = exerciseType
        self.allExerciseData = allExerciseData
        self.bodyExerciseData = bodyExerciseData
        self.machineExerciseData = machineExerciseData
    }
}

public struct PosturePartExerciseModel {
    public var image: UIImage
    public var name: String

    public init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
}

public struct PosturePartExerciseTypeModel {
    public var exerciseName: String

    public init(exerciseName: String) {
        self.exerciseName = exerciseName
    }
}
