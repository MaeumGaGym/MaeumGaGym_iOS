import UIKit

public struct PosturePartModel {
    public var exerciseType: [PosturePartExerciseTypeModel]
    public var exerciseData: [PosturePartExerciseModel]

    public init(exerciseType: [PosturePartExerciseTypeModel], exerciseData: [PosturePartExerciseModel]) {
        self.exerciseType = exerciseType
        self.exerciseData = exerciseData
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
