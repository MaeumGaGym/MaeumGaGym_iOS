import UIKit

public struct PostureRecommandModel {
    public var titleImage: UIImage
    public var titleText: String
    public var exerciseData: [PostureRecommandExerciseModel]

    public init(titleImage: UIImage, titleText: String, exerciseData: [PostureRecommandExerciseModel]) {
        self.titleImage = titleImage
        self.titleText = titleText
        self.exerciseData = exerciseData
    }
}

public struct PostureRecommandExerciseModel {
    public var image: UIImage
    public var name: String
    public var part: String

    public init(image: UIImage, name: String, part: String) {
        self.image = image
        self.name = name
        self.part = part
    }
}
