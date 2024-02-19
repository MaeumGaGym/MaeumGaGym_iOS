import UIKit

import RxSwift

import Domain
import DSKit

public class PostureService {
    public func requestRecommandData() ->
    Single<[PostureRecommandModel]> {
        let postureRecommandData: [PostureRecommandModel] = [
            PostureRecommandModel(
                titleImage: DSKitAsset.Assets.postureArmLogo.image,
                titleText: "맨몸 운동",
                exerciseData: [
                    PostureRecommandExerciseModel(image: DSKitAsset.Assets.pushUp.image, name: "푸시업", part: "가슴"),
                    PostureRecommandExerciseModel(image: DSKitAsset.Assets.bodySplitSqt.image, name: "맨몸 스플릿 스쿼트", part: "하체"),
                    PostureRecommandExerciseModel(image: DSKitAsset.Assets.backExtension.image, name: "백 익스텐션", part: "등")
                ]
            ),
            PostureRecommandModel(
                titleImage: DSKitAsset.Assets.postureDumbelLogo.image,
                titleText: "기구 운동",
                exerciseData: [
                    PostureRecommandExerciseModel(image: DSKitAsset.Assets.deeps.image, name: "딥스", part: "가슴"),
                    PostureRecommandExerciseModel(image: DSKitAsset.Assets.benchPress.image, name: "벤치프레스", part: "가슴"),
                    PostureRecommandExerciseModel(image: DSKitAsset.Assets.runge.image, name: "런지", part: "팔")
                ]
            )
        ]
        return Single.just(postureRecommandData)
    }
    
    public init() {
        
    }
}
