import UIKit
import SnapKit
import Then
import DSKit

public struct PostureExercise {
    var image: UIImage
    var name: String
}

public enum PostureExerciseModel {
    case chestBody
    case chestMachine
    

    var data: [PostureExercise] {
        switch self {
        case .chestBody:
            return [
                PostureExercise(image: DSKitAsset.Assets.postureChestTest1.image, name: "맨몸 스플릿 스쿼트"),
                PostureExercise(image: DSKitAsset.Assets.postureChestTest2.image, name: "에어 스쿼트"),
                PostureExercise(image: DSKitAsset.Assets.postureChestTest3.image, name: "점프 스쿼트"),
                PostureExercise(image: DSKitAsset.Assets.postureChestTest4.image, name: "스텝업"),
                PostureExercise(image: DSKitAsset.Assets.postureChestTest5.image, name: "런지"),
                PostureExercise(image: DSKitAsset.Assets.postureChestTest6.image, name: "힙 쓰러스트"),
                PostureExercise(image: DSKitAsset.Assets.postureChestTest7.image, name: "맨몸 오버헤드 스쿼트")
            ]
        case .chestMachine:
            return [
                PostureExercise(image: DSKitAsset.Assets.postureChestTest7.image, name: "맨몸 오버헤드 스쿼트"),
                PostureExercise(image: DSKitAsset.Assets.postureChestTest6.image, name: "힙 쓰러스트"),
                PostureExercise(image: DSKitAsset.Assets.postureChestTest5.image, name: "런지"),
                PostureExercise(image: DSKitAsset.Assets.postureChestTest4.image, name: "스텝업"),
                PostureExercise(image: DSKitAsset.Assets.postureChestTest3.image, name: "점프 스쿼트"),
                PostureExercise(image: DSKitAsset.Assets.postureChestTest2.image, name: "에어 스쿼트"),
                PostureExercise(image: DSKitAsset.Assets.postureChestTest1.image, name: "맨몸 스플릿 스쿼트")
            ]
        }
    }
}
