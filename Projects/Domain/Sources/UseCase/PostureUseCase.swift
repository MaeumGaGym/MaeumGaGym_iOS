import UIKit

import RxSwift

public protocol PostureUseCase {
    var recommandData: PublishSubject<[PostureRecommandModel]> { get }
    
    func getRecommandData()
}

public class DefaultPostureUseCase {
    private let repository: PostureRepositoryInterface
    private let disposeBag = DisposeBag()
    
    public let recommandData = PublishSubject<[PostureRecommandModel]>()
    
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
}
