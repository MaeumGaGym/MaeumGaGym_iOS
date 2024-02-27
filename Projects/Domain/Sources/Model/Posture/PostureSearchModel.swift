import UIKit

public struct PostureSearchModel {
    public var searchResultData: [PostureSearchContentModel]

    public init(searchResultData: [PostureSearchContentModel]) {
        self.searchResultData = searchResultData
    }
}

public struct PostureSearchContentModel {
    public var exerciseImage: UIImage
    public var exerciseName: String
    public var exercisePart: String

    public init(exerciseImage: UIImage, 
                exerciseName: String,
                exercisePart: String
    ) {
        self.exerciseImage = exerciseImage
        self.exerciseName = exerciseName
        self.exercisePart = exercisePart
    }
}
