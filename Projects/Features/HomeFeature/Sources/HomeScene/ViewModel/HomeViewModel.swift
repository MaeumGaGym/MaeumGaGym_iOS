import UIKit
import RxSwift
import RxCocoa
import Core
import Domain
import HomeFeatureInterface
import MGLogger

public class HomeViewModel: HomeViewModelType {
    
    public typealias ViewModel = HomeViewModel

    public var disposeBag: DisposeBag = DisposeBag()

    private let useCase: HomeUseCase

    public struct Input {
        let settingButtonTapped: Driver<Void>
        let getStepNumber: Driver<Void>
        let getMotivationMessage: Driver<Void>
        let getRoutines: Driver<Void>
        let getExtras: Driver<Void>
    }

    public struct Output {
        let settingButtonTapped: Driver<Void>
        var motivationMessage: Observable<MotivationMessageModel>
        var stepNumber: Observable<StepModel>
        var routines: Observable<[RoutineModel]>
        var extras: Observable<[ExtrasModel]>
    }

    public init(useCase: HomeUseCase) {
        self.useCase = useCase
    }

    public var onSettingButtonTap: (() -> Void)?
    public var onStepNumberButtonTap: (() -> Void)?
    public var routineButtonTap: (() -> Void)?
    public var calorieCalculatorButtonTap: (() -> Void)?
    public var maeumGaGymTimerButtonTap: (() -> Void)?

    private let isServiceAvailableSubject = PublishSubject<Bool>()
    private let motivationMessageSubject = PublishSubject<MotivationMessageModel>()
    private let stepNumberSubject = PublishSubject<StepModel>()
    private let routinesSubject = PublishSubject<[RoutineModel]>()
    private let extrasSubject = PublishSubject<[ExtrasModel]>()

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {

        let output = Output(
            settingButtonTapped: input.settingButtonTapped.asDriver(),
            motivationMessage: motivationMessageSubject.asObservable(),
            stepNumber: stepNumberSubject.asObservable(),
            routines: routinesSubject.asObservable(),
            extras: extrasSubject.asObservable()
        )

        action(output)

        self.bindOutput(output: output)

        input.settingButtonTapped
            .drive(onNext: { [weak self] _ in
                self?.onSettingButtonTap?()
                MGLogger.debug("SeetingButtonTapped")
            }).disposed(by: disposeBag)

        input.getStepNumber
            .drive(onNext: { [weak self] _ in
                self?.useCase.getStepNumber()
            }).disposed(by: disposeBag)

        input.getMotivationMessage
            .drive(onNext: { [weak self] _ in
                self?.useCase.getMotivationMessage()
            }).disposed(by: disposeBag)

        input.getRoutines
            .drive(onNext: { [weak self] _ in
                self?.useCase.getRoutines()
            }).disposed(by: disposeBag)

        input.getExtras
            .drive(onNext: { [weak self] _ in
                self?.useCase.getExtras()
            }).disposed(by: disposeBag)

        return output
    }

    private func bindOutput(output: Output) {

        useCase.motivationMessage
            .subscribe(onNext: { message in
                self.motivationMessageSubject.onNext(message)
            }).disposed(by: disposeBag)

        useCase.stepNumber
            .subscribe(onNext: { stepNumber in
                self.stepNumberSubject.onNext(stepNumber)
            }).disposed(by: disposeBag)

        useCase.routines
            .subscribe(onNext: { routines in
                self.routinesSubject.onNext(routines)
            }).disposed(by: disposeBag)

        useCase.extras
            .subscribe(onNext: { extras in
                self.extrasSubject.onNext(extras)
            }).disposed(by: disposeBag)
    }
}
