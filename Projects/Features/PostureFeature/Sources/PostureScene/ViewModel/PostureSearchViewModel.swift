import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class PostureSearchViewModel: BaseViewModel {

    private let disposeBag = DisposeBag()

    private let useCase: PostureUseCase

    public struct Input {
        let getSearchData: Driver<Void>
    }

    public struct Output {
        var searchData: Observable<PostureSearchModel>
    }

    private let searchDataSubject = PublishSubject<PostureSearchModel>()

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
            .drive(onNext: { [weak self] _ in
                self?.useCase.getSearchData()
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
