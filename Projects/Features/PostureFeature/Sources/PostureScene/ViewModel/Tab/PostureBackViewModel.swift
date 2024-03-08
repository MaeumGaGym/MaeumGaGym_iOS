import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public enum BackToggleButtonState {
    case checked
    case unChecked
}

public enum PostureBackModelState {
    case all
    case body
    case machine
}

public class PostureBackViewModel: BaseViewModel {
    
    public typealias ViewModel = PostureBackViewModel

    private let disposeBag = DisposeBag()

    private let useCase: PostureUseCase

    public struct Input {
        let firstButtonTapped: Driver<Void>
        let secondButtonTapped: Driver<Void>
        let getBackData: Driver<Void>
      }

      public struct Output {
          let firstButtonState: Observable<BackToggleButtonState>
          let secondButtonState: Observable<BackToggleButtonState>
          let backModelState:
          Observable<PostureBackModelState>
          var backData: Observable<PosturePartModel>
      }

    private let firstButtonStateSubject = BehaviorSubject<BackToggleButtonState>(value: .unChecked)
    private let secondButtonStateSubject = BehaviorSubject<BackToggleButtonState>(value: .unChecked)
    private let backModelStateSubject = BehaviorSubject<PostureBackModelState>(value: .all)

    private let backDataSubject = PublishSubject<PosturePartModel>()

    public init(useCase: PostureUseCase) {
        self.useCase = useCase
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let output = Output(
            firstButtonState: firstButtonStateSubject.asObservable(),
            secondButtonState:
                secondButtonStateSubject.asObservable(),
            backModelState: backModelStateSubject.asObservable(),
            backData: backDataSubject.asObservable()
        )

        action(output)

        self.bindOutput(output: output)

        input.firstButtonTapped
            .drive(onNext: { [weak self] _ in
                MGLogger.debug("PostureBack firstButtonTapped")
                let currentState = try? self?.firstButtonStateSubject.value()

                switch currentState {
                case .unChecked:
                    self?.firstButtonStateSubject.onNext(.checked)
                    self?.secondButtonStateSubject.onNext(.unChecked)
                    self?.backModelStateSubject.onNext(.body)
                case .checked:
                    self?.firstButtonStateSubject.onNext(.unChecked)
                    self?.backModelStateSubject.onNext(.all)
                case .none:
                    break
                }
            }).disposed(by: disposeBag)

        input.secondButtonTapped
            .drive(onNext: { [weak self] _ in
                MGLogger.debug("PostureBack secondButtonTapped")
                let currentState = try? self?.secondButtonStateSubject.value()

                switch currentState {
                case .unChecked:
                    self?.secondButtonStateSubject.onNext(.checked)
                    self?.firstButtonStateSubject.onNext(.unChecked)
                    self?.backModelStateSubject.onNext(.machine)
                case .checked:
                    self?.secondButtonStateSubject.onNext(.unChecked)
                    self?.backModelStateSubject.onNext(.all)
                case .none:
                    break
                }
            }).disposed(by: disposeBag)

        input.getBackData
            .drive(onNext: { [weak self] _ in
                self?.useCase.getPartData(type: .back)
            }).disposed(by: disposeBag)

        return output
    }

    private func bindOutput(output: Output) {
        useCase.partData
            .subscribe(onNext: { partData in
                self.backDataSubject.onNext(partData)
            }).disposed(by: disposeBag)
    }
}

