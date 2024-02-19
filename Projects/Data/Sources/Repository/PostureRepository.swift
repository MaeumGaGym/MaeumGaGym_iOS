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

    public init(networkService: PostureService) {
        self.networkService = networkService
    }
}
