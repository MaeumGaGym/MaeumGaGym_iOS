import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public enum ShoulderToggleButtonState {
    case checked
    case unChecked
}

public enum PostureSholderModelState {
    case all
    case body
    case machine
}

public class PostureShoulderViewModel: BaseViewModel {
    
    public typealias ViewModel = PostureShoulderViewModel

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
          var backData: Observable<PosePartModel>
      }

    private let firstButtonStateSubject = BehaviorSubject<BackToggleButtonState>(value: .unChecked)
    private let secondButtonStateSubject = BehaviorSubject<BackToggleButtonState>(value: .unChecked)
    private let backModelStateSubject = BehaviorSubject<PostureBackModelState>(value: .all)

    private let backDataSubject = PublishSubject<PosePartModel>()

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
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let currentState = try? owner.firstButtonStateSubject.value()

                switch currentState {
                case .unChecked:
                    owner.firstButtonStateSubject.onNext(.checked)
                    owner.secondButtonStateSubject.onNext(.unChecked)
                    owner.backModelStateSubject.onNext(.body)
                case .checked:
                    owner.firstButtonStateSubject.onNext(.unChecked)
                    owner.backModelStateSubject.onNext(.all)
                case .none:
                    break
                }
            }).disposed(by: disposeBag)

        input.secondButtonTapped
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let currentState = try? owner.secondButtonStateSubject.value()

                switch currentState {
                case .unChecked:
                    owner.secondButtonStateSubject.onNext(.checked)
                    owner.firstButtonStateSubject.onNext(.unChecked)
                    owner.backModelStateSubject.onNext(.machine)
                case .checked:
                    owner.secondButtonStateSubject.onNext(.unChecked)
                    owner.backModelStateSubject.onNext(.all)
                case .none:
                    break
                }
            }).disposed(by: disposeBag)

        input.getBackData
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.useCase.getShoulderData()
            }).disposed(by: disposeBag)

        return output
    }

    private func bindOutput(output: Output) {
        useCase.categoryShoulderData
            .subscribe(onNext: { partData in
                self.backDataSubject.onNext(partData)
            }).disposed(by: disposeBag)
    }
}

