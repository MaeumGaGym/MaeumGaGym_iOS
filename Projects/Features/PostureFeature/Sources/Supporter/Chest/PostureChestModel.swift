import UIKit
import SnapKit
import Then
import DSKit

public struct ChestExercise {
    var image: UIImage
    var name: String
}

public enum PostureChestModel {
    case first
    case second

    var data: [ChestExercise] {
        switch self {
        case .first:
            return [
                ChestExercise(image: DSKitAsset.Assets.postureChestTest1.image, name: "맨몸 스플릿 스쿼트"),
                ChestExercise(image: DSKitAsset.Assets.postureChestTest2.image, name: "에어 스쿼트"),
                ChestExercise(image: DSKitAsset.Assets.postureChestTest3.image, name: "점프 스쿼트"),
                ChestExercise(image: DSKitAsset.Assets.postureChestTest4.image, name: "스텝업"),
                ChestExercise(image: DSKitAsset.Assets.postureChestTest5.image, name: "런지"),
                ChestExercise(image: DSKitAsset.Assets.postureChestTest6.image, name: "힙 쓰러스트"),
                ChestExercise(image: DSKitAsset.Assets.postureChestTest7.image, name: "맨몸 오버헤드 스쿼트")
            ]
        case .second:
            return [
                ChestExercise(image: DSKitAsset.Assets.postureChestTest7.image, name: "맨몸 오버헤드 스쿼트"),
                ChestExercise(image: DSKitAsset.Assets.postureChestTest6.image, name: "힙 쓰러스트"),
                ChestExercise(image: DSKitAsset.Assets.postureChestTest5.image, name: "런지"),
                ChestExercise(image: DSKitAsset.Assets.postureChestTest4.image, name: "스텝업"),
                ChestExercise(image: DSKitAsset.Assets.postureChestTest3.image, name: "점프 스쿼트"),
                ChestExercise(image: DSKitAsset.Assets.postureChestTest2.image, name: "에어 스쿼트"),
                ChestExercise(image: DSKitAsset.Assets.postureChestTest1.image, name: "맨몸 스플릿 스쿼트")
            ]
        }
    }
}
