import UIKit

import DSKit

public struct MyRoutineEditContent {
    var image: UIImage
    var name: String
    var numberCount: String
    var setCount: String
}

public enum MyRoutineEditModel {
    case routineData
    
    var data: [MyRoutineEditContent] {
        switch self {
        case .routineData:
            return [
                MyRoutineEditContent(image: DSKitAsset.Assets.pullUp.image, name: "풀업", numberCount: "10", setCount: "20"),
                MyRoutineEditContent(image: DSKitAsset.Assets.pushUp.image, name: "푸시업", numberCount: "10", setCount: "4"),
                                     MyRoutineEditContent(image: DSKitAsset.Assets.airSqt.image, name: "에어 스쿼트", numberCount: "10", setCount: "3"),
                MyRoutineEditContent(image: DSKitAsset.Assets.babelLow.image, name: "바벨 로우", numberCount: "12", setCount: "2")
            ]
        }
    }
}


