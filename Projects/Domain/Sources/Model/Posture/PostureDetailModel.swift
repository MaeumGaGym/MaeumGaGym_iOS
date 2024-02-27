import UIKit

public struct PostureDetailModel {
    public var detailImage: UIImage
    public var titleTextData: PostureDetailTitleTextModel
    public var exerciseKindData: [PostureDetailExerciseKindModel]
    public var exerciseWayData: PostureDetailInfoModel
    public var exerciseCautionData: PostureDetailInfoModel
    public var relatedPickleData: PostureDetailPickleModel

    public init(detailImage: UIImage, 
                titleTextData: PostureDetailTitleTextModel,
                exerciseKindData: [PostureDetailExerciseKindModel],
                exerciseWayData: PostureDetailInfoModel,
                exerciseCautionData: PostureDetailInfoModel,
                relatedPickleData: PostureDetailPickleModel)
    {
        self.detailImage = detailImage
        self.titleTextData = titleTextData
        self.exerciseKindData = exerciseKindData
        self.exerciseWayData = exerciseWayData
        self.exerciseCautionData = exerciseCautionData
        self.relatedPickleData = relatedPickleData
    }
}

public struct PostureDetailTitleTextModel {
    public var englishName: String
    public var koreanName: String

    public init(englishName: String, koreanName: String) {
        self.englishName = englishName
        self.koreanName = koreanName
    }
}

public struct PostureDetailExerciseKindModel {
    public var exerciseTag: String
    
    public init(exerciseTag: String) {
        self.exerciseTag = exerciseTag
    }
}

public struct PostureDetailInfoModel {
    public var titleText: String
    public var infoText: [PostureDetailInfoTextModel]

    public init(titleText: String, infoText: [PostureDetailInfoTextModel]) {
        self.titleText = titleText
        self.infoText = infoText
    }
}

public struct PostureDetailInfoTextModel {
    public var text: String
    
    public init(text: String) {
        self.text = text
    }
}

public struct PostureDetailPickleModel{
    public var titleText: String
    public var pickleImage: [PostureDetailPickleImageModel]
    
    public init(titleText: String, pickleImage: [PostureDetailPickleImageModel]) {
        self.titleText = titleText
        self.pickleImage = pickleImage
    }
}

public struct PostureDetailPickleImageModel {
    public var image: UIImage

    public init(image: UIImage) {
        self.image = image
    }
}
