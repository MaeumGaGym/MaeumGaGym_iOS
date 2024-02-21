import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public class PostureDetailViewModel: BaseViewModel {

    private let disposeBag = DisposeBag()

    private let useCase: PostureUseCase

    public struct Input {
        let getDetailData: Driver<Void>
    }

    public struct Output {
        var detailData: Observable<PostureDetailModel>
    }

    private let detailDataSubject = PublishSubject<PostureDetailModel>()

    public init(useCase: PostureUseCase) {
        self.useCase = useCase
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let output = Output(
            detailData:
                detailDataSubject.asObservable()
        )

        action(output)

        self.bindOutput(output: output)

        input.getDetailData
            .drive(onNext: { [weak self] _ in
                self?.useCase.getDetailData(type: .pushUp)
            }).disposed(by: disposeBag)

        return output
    }

    private func bindOutput(output: Output) {
        useCase.detailData
            .subscribe(onNext: { detailData in
                self.detailDataSubject.onNext(detailData)
            }).disposed(by: disposeBag)
    }
}
