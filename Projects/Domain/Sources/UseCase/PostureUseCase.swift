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
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, recommandData in
                owner.recommandData.onNext(recommandData)
            }, onError: { error in
                print("PostureUseCase getRecommandData error occurred: \(error)")
            }
            ).disposed(by: disposeBag)
    }

    public func getPartData(type: PosturePartType) {
        repository.getPartData(type: type)
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, partData in
                owner.partData.onNext(partData)
            }, onError: { error in
                print("PostureUseCase getPartData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getDetailData(type: PostureDetailType) {
        repository.getDetailData(type: type)
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, detailData in
                owner.detailData.onNext(detailData)
            }, onError: { error in
                print("PostureUseCase getDetailData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getSearchData() {
        repository.getSearchData()
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, searchData in
                owner.searchData.onNext(searchData)
            }, onError: { error in
                print("PostureUseCase getSearchData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }
}
