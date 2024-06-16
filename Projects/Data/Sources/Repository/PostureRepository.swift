import RxSwift

import Domain
import MGNetworks

public class PostureRepository: PostureRepositoryInterface {

    private let networkService: PostureService

    public func getRecommandData() -> Single<[PostureRecommandModel]> {
        return networkService.requestRecommandData()
    }

    public func getPartData(type: PosturePartType) -> Single<PosturePartModel> {
        return networkService.requestPartData(type: type)
    }

    public func getDetailData(accessToken: String, id: Int) -> Single<PostureDetailModel> {
        return networkService.requestDetailData(accessToken: accessToken, id: id)
            .map(PoseDetailDTO.self)
            .map { $0.toDomain() }
    }

    public func getSearchData() -> Single<PostureSearchModel> {
        return networkService.requestSearchData()
    }

    public func getAllPoseData(accessToken: String, lastUpdated: String) -> Single<PostureAllModel> {
        return networkService.getAllPoseData(accessToken: accessToken, lastUpdated: lastUpdated)
            .map(PostureAllDTO.self)
            .map{ $0.toDomain() }
    }

    public init(networkService: PostureService) {
        self.networkService = networkService
    }
}
