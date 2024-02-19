import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain


public class PostureRecommandViewModel: BaseViewModel {
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    private let useCase: PostureUseCase


    public struct Input {
        let getRecommandData: Driver<Void>
    }

    public struct Output {
        var recommandData: Observable<[PostureRecommandModel]>
    }

    public init(useCase: PostureUseCase) {
        self.useCase = useCase
    }
    
    private let recommandDataSubject = PublishSubject<[PostureRecommandModel]>()
    
    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let output = Output(
            recommandData: recommandDataSubject.asObservable()
        )
        
        action(output)
        
        self.bindOutput(output: output)
        
        input.getRecommandData
            .drive(onNext: { [weak self] _ in
                self?.useCase.getRecommandData()
            }).disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output) {

        useCase.recommandData
            .subscribe(onNext: { recommandData in
                self.recommandDataSubject.onNext(recommandData)
            }).disposed(by: disposeBag)
    }
}
