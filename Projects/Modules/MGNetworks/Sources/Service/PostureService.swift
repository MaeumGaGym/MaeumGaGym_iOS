import UIKit

import RxSwift

import Domain
import DSKit

public class PostureRecommandService {
    public func requestRecommandTitle() ->
    Single<[PostureRecommandTitleModel]> {
        let titles: [PostureRecommandTitleModel] = [
            PostureRecommandTitleModel(image: DSKitAsset.Assets.postureArmLogo.image, title: "맨몸 운동"),
            PostureRecommandTitleModel(image: DSKitAsset.Assets.postureDumbelLogo.image, title: "기구 운동")
        ]
        return Single.just(titles)
    }
    
    public func requesRecommandFirstExercise() ->
    Single
    
    public init() {
        
    }
}
