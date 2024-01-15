import UIKit
import DSKit

public struct relatedPickle {
    var image: UIImage
}

public enum postureTitleImageModel {
    case pushUpModel
    
    var data: UIImage {
        switch self {
        case .pushUpModel:
            return DSKitAsset.Assets.pushUpDetail.image
        }
    }
}


public enum postureTitleLabelModel {
    case pushUpModel
    
    var englishName: String{
        switch self {
        case .pushUpModel:
            return"푸시업"
        }
    }
    
    var koreanName: String {
        switch self {
        case .pushUpModel:
            return "팔굽혀펴기"
        
        }
    }
}

public enum postureTagLabelModel {
    case pushUpModel
    
    var exerciseType: String {
        switch self {
        case .pushUpModel:
            return "맨몸"
        }
    }
    
    var exercisePart: String {
        switch self {
        case .pushUpModel:
            return "가슴"
        }
    }
}

public struct exerciseInfo {
    var num: String
    var way: String
}

public enum postureExerciseWayModel {
    case pushUpModel

    var data: [exerciseInfo] {
        switch self {
        case .pushUpModel:
            return [
                exerciseInfo(num: "01", way: "양팔을 가슴 옆에 두고 바닥에 엎드립니다."),
                exerciseInfo(num: "02", way: "복근과 둔근에 힘을 준 상태로 팔꿈치를 피며\n올라옵니다."),
                exerciseInfo(num: "03", way: "천천히 팔꿈치를 굽히며 시작 자세로 돌아갑니다.")
            ]
        }
    }
}

public struct exerciseCaution {
    var num: String
    var way: String
}

public enum postureExerciseCautionModel {
    case pushUpModel

    var data: [exerciseInfo] {
        switch self {
        case .pushUpModel:
            return [
                exerciseInfo(num: "01", way: "양팔을 가슴 옆에 두고 바닥에 엎드립니다."),
                exerciseInfo(num: "02", way: "복근과 둔근에 힘을 준 상태로 팔꿈치를 피며\n올라옵니다."),
            ]
        }
    }
}

public enum postureRelatedPickleModel {
    case pushUpModel
    
    var data: [relatedPickle] {
        switch self {
        case .pushUpModel:
            return [
                relatedPickle(image: DSKitAsset.Assets.posturePickleTest1.image),
                 relatedPickle(image: DSKitAsset.Assets.posturePickleTest2.image),
                 relatedPickle(image: DSKitAsset.Assets.posturePickleTest3.image),
                 relatedPickle(image: DSKitAsset.Assets.posturePickleTest4.image)
            ]
        }
    }
}
