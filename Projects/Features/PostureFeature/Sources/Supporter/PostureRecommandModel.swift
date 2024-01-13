import UIKit
import DSKit

struct Exercise {
    var image: UIImage
    var name: String
    var part: String
}

enum PostureRecommandModel {
    case first
    case second
    
    var data: [Exercise] {
        switch self {
        case .first:
            return [
                Exercise(image: DSKitAsset.Assets.pushUp.image, name: "푸시업", part: "가슴"),
                Exercise(image: DSKitAsset.Assets.reverseCrunch.image, name: "리버스 크런치", part: "복근"),
                Exercise(image: DSKitAsset.Assets.hollowPosition.image, name: "할로우 포지션", part: "복근")
            ]
        case .second:
            return [
                Exercise(image: DSKitAsset.Assets.dumbbellSquat.image, name: "덤벨 스쿼트", part: "복근"),
                Exercise(image: DSKitAsset.Assets.cableTrisemExtension.image, name: "케이블 트리이셉", part: "다리"),
                Exercise(image: DSKitAsset.Assets.hammerBenchPress.image, name: "헤머 벤치프레스", part: "팔")
            ]
        }
    }
    
    var logo: UIImage {
        switch self {
        case .first:
            return DSKitAsset.Assets.arm.image
        case .second:
            return DSKitAsset.Assets.blueDumbbel.image
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

