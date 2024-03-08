import UIKit

import RxSwift

public enum PosturePartType {
    case chest
    case back
}

public enum PostureDetailType {
    case pushUp
}

public protocol PostureRepositoryInterface {
    func getRecommandData() -> Single<[PostureRecommandModel]>
    func getPartData(type: PosturePartType) -> Single<PosturePartModel>
    func getDetailData(type: PostureDetailType) -> Single<PostureDetailModel>
    func getSearchData() -> Single<PostureSearchModel>
}
