import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core
import Domain
import MGLogger

public enum ChestToggleButtonState {
    case checked
    case unchecked
}

public enum PostureChestModelState {
    case all
    case body
    case machine
}

public class PostureChestViewModel: BaseViewModel {

    private let disposeBag = DisposeBag()

    private let useCase: PostureUseCase

    public struct Input {
        let firstButtonTapped: Driver<Void>
        let secondButtonTapped: Driver<Void>
        let getChestData: Driver<Void>
    }

    public struct Output {
        let firstButtonState: Observable<ChestToggleButtonState>
        let secondButtonState: Observable<ChestToggleButtonState>
        let chestModelState:
        Observable<PostureChestModelState>
        var chestData: Observable<PosturePartModel>
    }

    private let firstButtonStateSubject = BehaviorSubject<ChestToggleButtonState>(value: .unchecked)
    private let secondButtonStateSubject = BehaviorSubject<ChestToggleButtonState>(value: .unchecked)
    private let chestModelStateSubject = BehaviorSubject<PostureChestModelState>(value: .all)

    private let chestDataSubject = PublishSubject<PosturePartModel>()

    public init(useCase: PostureUseCase) {
        self.useCase = useCase
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let output = Output(
            firstButtonState: firstButtonStateSubject.asObservable(),
            secondButtonState:
                secondButtonStateSubject.asObservable(),
            chestModelState: chestModelStateSubject.asObservable(),
            chestData: chestDataSubject.asObservable()
        )

        action(output)

        self.bindOutput(output: output)

        input.firstButtonTapped
            .drive(onNext: { [weak self] _ in
                MGLogger.debug("firstButtonTapped")
                let currentState = try? self?.firstButtonStateSubject.value()

                switch currentState {
                case .unchecked:
                    self?.firstButtonStateSubject.onNext(.checked)
                    self?.secondButtonStateSubject.onNext(.unchecked)
                    self?.chestModelStateSubject.onNext(.body)
                case .checked:
                    self?.firstButtonStateSubject.onNext(.unchecked)
                    self?.chestModelStateSubject.onNext(.all)
                case .none:
                    break
                }
            }).disposed(by: disposeBag)

        input.secondButtonTapped
            .drive(onNext: { [weak self] _ in
                MGLogger.debug("firstButtonTapped")
                let currentState = try? self?.secondButtonStateSubject.value()

                switch currentState {
                case .unchecked:
                    self?.secondButtonStateSubject.onNext(.checked)
                    self?.firstButtonStateSubject.onNext(.unchecked)
                    self?.chestModelStateSubject.onNext(.machine)
                case .checked:
                    self?.secondButtonStateSubject.onNext(.unchecked)
                    self?.chestModelStateSubject.onNext(.all)
                case .none:
                    break
                }
            }).disposed(by: disposeBag)

        input.getChestData
            .drive(onNext: { [weak self] _ in
                self?.useCase.getPartData(type: .chest)
            }).disposed(by: disposeBag)

        return output
    }

    private func bindOutput(output: Output) {

        useCase.partData
            .subscribe(onNext: { partData in
                self.chestDataSubject.onNext(partData)
            }).disposed(by: disposeBag)
    }
}
