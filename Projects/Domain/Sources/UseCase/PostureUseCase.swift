import UIKit

import RxSwift

public protocol PostureUseCase {
    var recommandData: PublishSubject<[PostureRecommandModel]> { get }
    var partData: PublishSubject<PosturePartModel> { get }
    var detailData: PublishSubject<PostureDetailModel> { get }
    var searchData: PublishSubject<PostureSearchModel> { get }

    func getRecommandData()
    func getPartData(type: PosturePartType)
    func getDetailData(type: PostureDetailType)
    func getSearchData()
}

public class DefaultPostureUseCase {
    private let repository: PostureRepositoryInterface
    private let disposeBag = DisposeBag()

    public let recommandData = PublishSubject<[PostureRecommandModel]>()
    public let partData = PublishSubject<PosturePartModel>()
    public let detailData = PublishSubject<PostureDetailModel>()
    public let searchData = PublishSubject<PostureSearchModel>()

    public init(repository: PostureRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultPostureUseCase: PostureUseCase {

    public func getRecommandData() {
        repository.getRecommandData()
            .subscribe(onSuccess: { [weak self] recommandData in
                self?.recommandData.onNext(recommandData)
            },
            onFailure: { error in
                print("PostureUseCase getRecommandData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getPartData(type: PosturePartType) {
        repository.getPartData(type: type)
            .subscribe(onSuccess: { [weak self] partData in
                self?.partData.onNext(partData)
            },
            onFailure: { error in
                print("PostureUseCase getPartData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getDetailData(type: PostureDetailType) {
        repository.getDetailData(type: type)
            .subscribe(onSuccess: { [weak self] detailData in
                self?.detailData.onNext(detailData)
            },
            onFailure: { error in
                print("PostureUseCase getDetailData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getSearchData() {
        repository.getSearchData()
            .subscribe(onSuccess: { [weak self] searchData in
                self?.searchData.onNext(searchData)
            },
            onFailure: { error in
                print("PostureUseCase getSearchData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }
}
