import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core

public enum backToggleButtonState {
    case checked
    case unChecked
}

public class PostureBackViewModel: BaseViewModel {

    let disposeBag = DisposeBag()

    public struct Input {
          let firstButtonTapped: Observable<Void>
          let secondButtonTapped: Observable<Void>
      }

      public struct Output {
          let backModel: Observable<PostureExerciseModel>
          let firstButtonState: Observable<backToggleButtonState>
          let secondButtonState: Observable<backToggleButtonState>
      }

    private let backEntireModelSubject = BehaviorSubject<PostureExerciseModel>(value: .back)
    private let firstButtonStateSubject = BehaviorSubject<backToggleButtonState> (value: .unChecked)
    private let secondButtonStateSubject = BehaviorSubject<backToggleButtonState>(value: .unChecked)

    public init() {}

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
          input.firstButtonTapped
              .subscribe(onNext: { [self] in
                  let currentState = try? firstButtonStateSubject.value()
                  switch currentState {
                  case .unChecked:
                      firstButtonStateSubject.onNext(.checked)
                      secondButtonStateSubject.onNext(.unChecked)
                      backEntireModelSubject.onNext(.backBody)
                  case .checked:
                      firstButtonStateSubject.onNext(.unChecked)
                      backEntireModelSubject.onNext(.back)
                  case .none:
                      break
                  }
              }).disposed(by: disposeBag)
          
          input.secondButtonTapped
              .subscribe(onNext: { [self] in
                  let currentState = try? self.secondButtonStateSubject.value()
                  switch currentState {
                  case .unChecked:
                      secondButtonStateSubject.onNext(.checked)
                      firstButtonStateSubject.onNext(.unChecked)
                      backEntireModelSubject.onNext(.backMachine)
                  case .checked:
                      secondButtonStateSubject.onNext(.unChecked)
                      backEntireModelSubject.onNext(.back)
                  case .none:
                      break
                  }
              }).disposed(by: disposeBag)
          
          return Output(backModel: backEntireModelSubject.asObservable(),
                        firstButtonState: firstButtonStateSubject.asObservable(),
                        secondButtonState: secondButtonStateSubject.asObservable())
      }
}

