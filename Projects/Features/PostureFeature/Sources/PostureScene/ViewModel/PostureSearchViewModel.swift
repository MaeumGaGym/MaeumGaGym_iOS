import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class PostureSearchViewModel: BaseViewModel {
    
    public typealias ViewModel = PostureSearchViewModel

    private let disposeBag = DisposeBag()

    private let useCase: PostureUseCase

    public struct Input {
        let getSearchData: Driver<String>
    }

    public struct Output {
        var searchData: Observable<PosePartModel>
    }

    private let searchDataSubject = PublishSubject<PosePartModel>()

    public init(useCase: PostureUseCase) {
        self.useCase = useCase
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let output = Output(
            searchData:
                searchDataSubject.asObservable()
        )

        action(output)

        self.bindOutput(output: output)

        input.getSearchData
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, category in
                owner.useCase.getSearchData(category: category)
            }).disposed(by: disposeBag)

        return output
    }

    private func bindOutput(output: Output) {
        useCase.searchData
            .subscribe(onNext: { searchData in
                self.searchDataSubject.onNext(searchData)
            }).disposed(by: disposeBag)
    }
}
