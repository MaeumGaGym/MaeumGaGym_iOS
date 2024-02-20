import UIKit

import RxSwift

public protocol PostureUseCase {
    var recommandData: PublishSubject<[PostureRecommandModel]> { get }
    var partData: PublishSubject<PosturePartModel> { get }
    var detailData: PublishSubject<PostureDetailModel> { get }

    func getRecommandData()
    func getPartData(type: PosturePartType)
    func getDetailData(type: PostureDetailType)
}

public class DefaultPostureUseCase {
    private let repository: PostureRepositoryInterface
    private let disposeBag = DisposeBag()

    public let recommandData = PublishSubject<[PostureRecommandModel]>()
    public let partData = PublishSubject<PosturePartModel>()
    public let detailData = PublishSubject<PostureDetailModel>()

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
}
