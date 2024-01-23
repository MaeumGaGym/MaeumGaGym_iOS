import Foundation
import RxFlow
import RxCocoa
import RxSwift
import Core

public enum backToggleButtonState {
    case checked
    case unchecked
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
      private let firstButtonStateSubject = BehaviorSubject<backToggleButtonState>(value: .unchecked)
      private let secondButtonStateSubject = BehaviorSubject<backToggleButtonState>(value: .unchecked)
      
      public init() {}
      
      public func transform(_ input: Input) -> Output {
          input.firstButtonTapped
              .subscribe(onNext: { [weak self] in
                  let currentState = try? self?.firstButtonStateSubject.value()
                  let currentModel = try? self?.backEntireModelSubject.value()
                  switch currentState {
                  case .unchecked:
                      self?.firstButtonStateSubject.onNext(.checked)
                      self?.secondButtonStateSubject.onNext(.unchecked)
                      self?.backEntireModelSubject.onNext(.backBody)
                  case .checked:
                      self?.firstButtonStateSubject.onNext(.unchecked)
                      if currentModel == .backBody {
                          self?.backEntireModelSubject.onNext(.back)
                      }
                  case .none:
                      break
                  }
              }).disposed(by: disposeBag)
          
          input.secondButtonTapped
              .subscribe(onNext: { [weak self] in
                  let currentState = try? self?.secondButtonStateSubject.value()
                  let currentModel = try? self?.backEntireModelSubject.value()
                  switch currentState {
                  case .unchecked:
                      self?.secondButtonStateSubject.onNext(.checked)
                      self?.firstButtonStateSubject.onNext(.unchecked)
                      self?.backEntireModelSubject.onNext(.backMachine)
                  case .checked:
                      self?.secondButtonStateSubject.onNext(.unchecked)
                      if currentModel == .backMachine {
                          self?.backEntireModelSubject.onNext(.back)
                      }
                  case .none:
                      break
                  }
              }).disposed(by: disposeBag)
          
          return Output(backModel: backEntireModelSubject.asObservable(),
                        firstButtonState: firstButtonStateSubject.asObservable(),
                        secondButtonState: secondButtonStateSubject.asObservable())
      }
}

