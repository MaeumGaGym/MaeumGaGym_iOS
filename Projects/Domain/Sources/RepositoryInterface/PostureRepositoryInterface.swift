import UIKit

import RxSwift

public enum PosturePartType {
    case chest
    case back
}

public protocol PostureRepositoryInterface {
    func getRecommandData() -> Single<[PostureRecommandModel]>
    func getPartData(type: PosturePartType) -> Single<PosturePartModel>
    func getDetailData(accessToken: String, id: Int) -> Single<PostureDetailModel>
    func getSearchData() -> Single<PostureSearchModel>
    func getAllPoseData(accessToken: String, lastUpdated: String) -> Single<PostureAllModel>
}
