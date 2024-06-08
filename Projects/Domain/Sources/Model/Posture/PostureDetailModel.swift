import UIKit

public struct PostureDetailModel_temporary {
    public var needMachine: Bool
    public var category: [String]
    public var simpleName, exactName: String
    public var thumbnail: String
    public var video: String
    public var simplePart, exactPart, startPose, exerciseWay: [String]
    public var breatheWay, caution: [String]
    public var pickleImage: [UIImage]
    
    public init(needMachine: Bool, category: [String], simpleName: String, exactName: String, thumbnail: String, video: String, simplePart: [String], exactPart: [String], startPose: [String], exerciseWay: [String], breatheWay: [String], caution: [String], pickleImage: [UIImage]) {
        self.needMachine = needMachine
        self.category = category
        self.simpleName = simpleName
        self.exactName = exactName
        self.thumbnail = thumbnail
        self.video = video
        self.simplePart = simplePart
        self.exactPart = exactPart
        self.startPose = startPose
        self.exerciseWay = exerciseWay
        self.breatheWay = breatheWay
        self.caution = caution
        self.pickleImage = pickleImage
    }
}

public struct PostureDetailModel {
    public var detailImage: UIImage
    public var titleTextData: PostureDetailTitleTextModel
    public var exerciseKindData: [PostureDetailExerciseKindModel]
    public var exercisePartData: PostureDetailInfoModel
    public var exerciseStartData: PostureDetailInfoModel
    public var exerciseWayData: PostureDetailInfoModel
    public var exerciseBreathData: PostureDetailInfoModel
    public var exerciseCautionData: PostureDetailInfoModel
    public var relatedPickleData: PostureDetailPickleModel

    public init(detailImage: UIImage, 
                titleTextData: PostureDetailTitleTextModel,
                exerciseKindData: [PostureDetailExerciseKindModel],
                exercisePartData: PostureDetailInfoModel,
                exerciseStartData: PostureDetailInfoModel,
                exerciseWayData: PostureDetailInfoModel,
                exerciseBreathData: PostureDetailInfoModel,
                exerciseCautionData: PostureDetailInfoModel,
                relatedPickleData: PostureDetailPickleModel)
    {
        self.detailImage = detailImage
        self.titleTextData = titleTextData
        self.exerciseKindData = exerciseKindData
        self.exercisePartData = exercisePartData
        self.exerciseStartData = exerciseStartData
        self.exerciseWayData = exerciseWayData
        self.exerciseBreathData = exerciseBreathData
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
