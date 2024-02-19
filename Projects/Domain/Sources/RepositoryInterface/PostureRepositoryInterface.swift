import UIKit

import RxSwift

public enum PosturePartType {
    case chest
    case back
}

public protocol PostureRepositoryInterface {
    func getRecommandData() -> Single<[PostureRecommandModel]>
    func getPartData(type: PosturePartType) -> Single<PosturePartModel>
}
