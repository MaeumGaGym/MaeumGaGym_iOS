import Foundation
import RxFlow
import RxCocoa
import RxSwift
import Core

public enum chestToggleButtonState {
    case checked
    case unchecked
}

public class PostureChestViewModel: BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    public struct Input {
          let firstButtonTapped: Observable<Void>
          let secondButtonTapped: Observable<Void>
      }
      
      public struct Output {
          let chestModel: Observable<PostureExerciseModel>
          let firstButtonState: Observable<chestToggleButtonState>
          let secondButtonState: Observable<chestToggleButtonState>
      }
      
      private let chestEntireModelSubject = BehaviorSubject<PostureExerciseModel>(value: .chest)
      private let firstButtonStateSubject = BehaviorSubject<chestToggleButtonState>(value: .unchecked)
      private let secondButtonStateSubject = BehaviorSubject<chestToggleButtonState>(value: .unchecked)
      
      public init() {}
      
      public func transform(_ input: Input) -> Output {
          input.firstButtonTapped
              .subscribe(onNext: { [weak self] in
                  let currentState = try? self?.firstButtonStateSubject.value()
                  let currentModel = try? self?.chestEntireModelSubject.value()
                  switch currentState {
                  case .unchecked:
                      self?.firstButtonStateSubject.onNext(.checked)
                      self?.secondButtonStateSubject.onNext(.unchecked)
                      self?.chestEntireModelSubject.onNext(.chestBody)
                  case .checked:
                      self?.firstButtonStateSubject.onNext(.unchecked)
                      if currentModel == .chestBody {
                          self?.chestEntireModelSubject.onNext(.chest)
                      }
                  case .none:
                      break
                  }
              }).disposed(by: disposeBag)
          
          input.secondButtonTapped
              .subscribe(onNext: { [weak self] in
                  let currentState = try? self?.secondButtonStateSubject.value()
                  let currentModel = try? self?.chestEntireModelSubject.value()
                  switch currentState {
                  case .unchecked:
                      self?.secondButtonStateSubject.onNext(.checked)
                      self?.firstButtonStateSubject.onNext(.unchecked)
                      self?.chestEntireModelSubject.onNext(.chestMachine)
                  case .checked:
                      self?.secondButtonStateSubject.onNext(.unchecked)
                      if currentModel == .chestMachine {
                          self?.chestEntireModelSubject.onNext(.chest)
                      }
                  case .none:
                      break
                  }
              }).disposed(by: disposeBag)
          
          return Output(chestModel: chestEntireModelSubject.asObservable(),
                        firstButtonState: firstButtonStateSubject.asObservable(),
                        secondButtonState: secondButtonStateSubject.asObservable())
      }
}
