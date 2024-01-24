import UIKit
import DSKit

public struct Exercise {
    var image: UIImage
    var name: String
    var part: String
}

public enum PostureRecommandModel {
    case first
    case second

    var data: [Exercise] {
        switch self {
        case .first:
            return [
                Exercise(image: DSKitAsset.Assets.pushUp.image, name: "푸시업", part: "가슴"),
                Exercise(image: DSKitAsset.Assets.bodySplitSqt.image, name: "맨몸 스플릿 스쿼트", part: "하체"),
                Exercise(image: DSKitAsset.Assets.backExtension.image, name: "백 익스텐션", part: "등")
            ]
        case .second:
            return [
                Exercise(image: DSKitAsset.Assets.deeps.image, name: "딥스", part: "가슴"),
                Exercise(image: DSKitAsset.Assets.benchPress.image, name: "벤치프레스", part: "가슴"),
                Exercise(image: DSKitAsset.Assets.runge.image, name: "런지", part: "팔")
            ]
        }
    }

    var logo: UIImage {
        switch self {
        case .first:
            return DSKitAsset.Assets.postureArmLogo.image
        case .second:
            return DSKitAsset.Assets.postureDumbelLogo.image
        }
    }

    var title: String {
        switch self {
        case .first:
            return "맨몸 운동"
        case .second:
            return "기구 운동"
        }
    }
}
