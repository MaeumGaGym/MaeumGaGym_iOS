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

    public init(exerciseImage: UIImage, exerciseName: String) {
        self.exerciseImage = exerciseImage
        self.exerciseName = exerciseName
    }
}
