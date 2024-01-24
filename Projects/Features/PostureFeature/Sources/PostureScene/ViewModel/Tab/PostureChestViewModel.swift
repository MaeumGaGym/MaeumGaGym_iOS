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
            .subscribe(onNext: { [self] in
                let currentState = try? firstButtonStateSubject.value()
                switch currentState {
                case .unchecked:
                    firstButtonStateSubject.onNext(.checked)
                    secondButtonStateSubject.onNext(.unchecked)
                    chestEntireModelSubject.onNext(.chestBody)
                case .checked:
                    firstButtonStateSubject.onNext(.unchecked)
                    chestEntireModelSubject.onNext(.chest)
                case .none:
                    break
                }
            }).disposed(by: disposeBag)
        
        input.secondButtonTapped
            .subscribe(onNext: { [self] in
                let currentState = try? secondButtonStateSubject.value()
                switch currentState {
                case .unchecked:
                    secondButtonStateSubject.onNext(.checked)
                    firstButtonStateSubject.onNext(.unchecked)
                    chestEntireModelSubject.onNext(.chestMachine)
                case .checked:
                    secondButtonStateSubject.onNext(.unchecked)
                    chestEntireModelSubject.onNext(.chest)
                case .none:
                    break
                }
            }).disposed(by: disposeBag)
        
        return Output(chestModel: chestEntireModelSubject.asObservable(),
                      firstButtonState: firstButtonStateSubject.asObservable(),
                      secondButtonState: secondButtonStateSubject.asObservable())
    }
}
