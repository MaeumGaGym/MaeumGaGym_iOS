import UIKit

import RxSwift

public enum PosturePartType {
    case chest
    case back
}

public protocol PostureRepositoryInterface {
    func getRecommandData(accessToken: String) -> Single<PoseRecommandModel>
    func getPartData(accessToken: String, category: String) -> Single<PosePartModel>
    func getDetailData(accessToken: String, id: Int) -> Single<PostureDetailModel>
    func getSearchData() -> Single<PostureSearchModel>
    func getAllPoseData(accessToken: String, lastUpdated: String) -> Single<PostureAllModel>
}
