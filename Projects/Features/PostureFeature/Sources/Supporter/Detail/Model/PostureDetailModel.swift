import UIKit
import DSKit

public struct titleImage {
    var image: UIImage
}

public struct titleLabel {
    var englishName: String
    var koreanName: String
}

public struct tagLabel {
    var exerciseType: String
    var exercisePart: String
}

public struct exerciseInfo {
    var firstNum: String
    var firstWay: String
    var secondNum: String
    var secondWay: String
    var thirdNum: String
    var thirdWay: String
}

public struct exerciseCaution {
    var firstNum: String
    var firstWay: String
    var secondNum: String
    var secondWay: String
}

public struct relatedPickle {
    var image: UIImage
}

public enum postureTitleImageModel {
    case pushUpModel
    
    var data: [titleImage] {
        switch self {
        case .pushUpModel:
            return[(titleImage(image: DSKitAsset.Assets.pushUpDetail.image))]
        }
    }
}


public enum postureTitlelabelModel {
    case pushUpModel
    
    var data: [titleLabel] {
        switch self {
        case .pushUpModel:
            return[(titleLabel(englishName: "푸시업", koreanName: "팔굽혀펴기"))]
        }
    }
}

public enum postureTagLabelModel {
    case pushUpModel
    
    var data: [tagLabel] {
        switch self {
        case .pushUpModel:
            return[(tagLabel(exerciseType: "맨몸", exercisePart: "가슴"))]
        }
    }
}

public enum postureExerciseWayModel {
    case pushUpModel
    
    var data: [exerciseInfo] {
        switch self {
        case .pushUpModel:
            return[(exerciseInfo(firstNum: "01", firstWay: "양팔을 가슴 옆에 두고 바닥에 엎드립니다.", secondNum: "02", secondWay: "복근과 둔근에 힘을 준 상태로 팔꿈치를 피며\n올라옵니다.", thirdNum: "03", thirdWay: "천천히 팔꿈치를 굽히며 시작 자세로 돌아갑니다."))]
        }
    }
}

public enum pstureExerciseCautionModel {
    case pushUpModel
    
    var data: [exerciseCaution] {
        switch self {
        case .pushUpModel:
            return[(exerciseCaution(firstNum: "01", firstWay: "양팔을 가슴 옆에 두고 바닥에 엎드립니다.", secondNum: "02", secondWay: "복근과 둔근에 힘을 준 상태로 팔꿈치를 피며\n올라옵니다."))]
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
