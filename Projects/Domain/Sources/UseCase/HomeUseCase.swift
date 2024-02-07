import UIKit
import RxSwift
import RxCocoa
import Core

public protocol HomeUseCase {
    var motivationMessage: PublishSubject<MotivationMessageModel> { get }
    var stepNumber: PublishSubject<StepModel> { get }
    var routines: PublishSubject<[RoutineModel]> { get }
    var extras: PublishSubject<[ExtrasModel]> { get }
    
    func getMotivationMessage()
    func getStepNumber()
    func getRoutines()
    func getExtras()
}

public class DefaultHomeUseCase {
  
    private let repository: HomeRepositoryInterface
    private let disposeBag = DisposeBag()
    
    public let motivationMessage = PublishSubject<MotivationMessageModel>()
    public let stepNumber = PublishSubject<StepModel>()
    public let routines = PublishSubject<[RoutineModel]>()
    public let extras = PublishSubject<[ExtrasModel]>()
    
    public init(repository: HomeRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultHomeUseCase: HomeUseCase {
    
    public func getMotivationMessage() {
        repository.getMotivationMessage()
            .subscribe(
                onSuccess: { [weak self] messageModel in
                    self?.motivationMessage.onNext(messageModel)
                },
                onFailure: { [weak self] error in
                    print("HomeUseCase getMotivationMessage error occurred: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    public func getStepNumber() {
        repository.getStepNumber()
            .subscribe(
                onSuccess: { [weak self] stepModel in
                    self?.stepNumber.onNext(stepModel)
                },
                onFailure: { [weak self] error in
                    print("HomeUseCase getStepNumber error occurred: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    public func getRoutines() {
        repository.getRoutines()
            .subscribe(
                onSuccess: { [weak self] routines in
                    self?.routines.onNext(routines)
                },
                onFailure: { [weak self] error in
                    print("HomeUseCase getRoutines error occurred: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    public func getExtras() {
        repository.getExtras()
            .subscribe(
                onSuccess: { [weak self] extras in
                    self?.extras.onNext(extras)
                },
                onFailure: { [weak self] error in
                    print("HomeUseCase getExtras error occurred: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
}
