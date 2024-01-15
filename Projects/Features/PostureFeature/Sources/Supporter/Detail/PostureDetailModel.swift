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
    var image1: UIImage
    var image2: UIImage
    var image3: UIImage
    var image4: UIImage
}

case exerciseWay
case exerciseCaution
case relatedPickle

public enum titleImageModel {
    case pushUpModel
    
    var data: [titleImage] {
        switch self {
        case .pushUpModel:
            return[(titleImage(image: DSKitAsset.Assets.pushUpDetail.image))]
        }
    }
}


public enum titlelabelModel {
    case pushUpModel
    
    var data: [titleLabel] {
        switch self {
        case .pushUpModel:
            return[(titleLabel(englishName: "푸시업", koreanName: "팔굽혀펴기"))]
        }
    }
}

public enum tagLabelModel {
    case pushUpModel
    
    var data: [tagLabel] {
        switch self {
        case .pushUpModel:
            return[(tagLabel(exerciseType: "맨몸", exercisePart: "가슴"))]
        }
    }
}

public enum exerciseWayModel {
    case pushUpModel
    
    var data: [exerciseInfo] {
        switch self {
        case .pushUpModel:
            return[(exerciseInfo(firstNum: "01", firstWay: "양팔을 가슴 옆에 두고 바닥에 엎드립니다.", secondNum: "02", secondWay: "복근과 둔근에 힘을 준 상태로 팔꿈치를 피며\n올라옵니다.", thirdNum: "03", thirdWay: "천천히 팔꿈치를 굽히며 시작 자세로 돌아갑니다."))]
        }
    }
}

public enum exerciseCautionModel {
    case pushUpModel
    
    var data: [exerciseCaution] {
        switch self {
        case .pushUpModel:
            return[(exerciseCaution(firstNum: "01", firstWay: "양팔을 가슴 옆에 두고 바닥에 엎드립니다.", secondNum: "02", secondWay: "복근과 둔근에 힘을 준 상태로 팔꿈치를 피며\n올라옵니다."))]
        }
    }
}

public enum relatedPickleModel {
    case pushUpModel
    
    var data: [relatedPickle] {
        switch self {
        case .pushUpModel:
            return [(relatedPickle(image1: DSKitAsset.Assets.posturePickleTest1.image, image2: DSKitAsset.Assets.posturePickleTest2.image, image3: DSKitAsset.Assets.posturePickleTest3.image, image4: DSKitAsset.Assets.posturePickleTest4.image))]
        }
    }
}
