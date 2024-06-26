//import Foundation
//
//import RxSwift
//import RxCocoa
//import RxFlow
//
//import Core
//import Domain
//import SafariServices
//
//public class AgreeViewModel: BaseViewModel {
//
//    public typealias ViewModel = AgreeViewModel
//
//    private let useCase: AuthUseCase
//
//    public var disposeBag: DisposeBag = DisposeBag()
//
//    public struct Input {
//        let navButtonTapped: Driver<Void>
//        let allAgreeButtonTap: Signal<Void>
//        let firstAgreeButtonTap: Signal<Void>
//        let firstSeeMoreButtonTap: Driver<Void>
//        let secondAgreeButtonTap: Signal<Void>
//        let secondSeeMoreButtonTap: Single<Void>
//        let thirdAgreeButtonTap: Signal<Void>
//        let fourthAgreeButtonTap: Signal<Void>
//        let nextButtonTap: Signal<Void>
//    }
//
//    public struct Output {
//        let navButtonTapped: Driver<Void>
//        let allAgreeButtonClickedMessage: Observable<String>
//        let firstAgreeButtonClickedMessage: Observable<String>
//        let secondAgreeButtonClickedMessage: Observable<String>
//        let thirdAgreeButtonClickedMessage: Observable<String>
//        let fourthAgreeButtonClickedMessage: Observable<String>
//        let nextButtonClicked: Driver<Bool>
//    }
//
//    public init(useCase: AuthUseCase) {
//        self.useCase = useCase
//    }
//
//    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
//
//        let allAgreeClickedMessage = input.allAgreeButtonTap.map { "전체 클릭" }.asObservable()
//        let firstAgreeClickedMessage = input.firstAgreeButtonTap.map { "첫 번째 동의 클릭" }.asObservable()
//        let secondAgreeClickedMessage = input.secondAgreeButtonTap.map { "두 번째 동의 클릭" }.asObservable()
//        let thirdAgreeClickedMessage = input.thirdAgreeButtonTap.map { "세 번째 동의 클릭" }.asObservable()
//        let fourthAgreeClickedMessage = input.fourthAgreeButtonTap.map { "네 번째 동의 클릭" }.asObservable()
//        let nextButtonClicked = input.nextButtonTap.map { true }.asDriver(onErrorJustReturn: false)
//
//        let output = Output(navButtonTapped: input.navButtonTapped.asDriver(),
//                            allAgreeButtonClickedMessage: allAgreeClickedMessage,
//                            firstAgreeButtonClickedMessage: firstAgreeClickedMessage,
//                            secondAgreeButtonClickedMessage: secondAgreeClickedMessage,
//                            thirdAgreeButtonClickedMessage: thirdAgreeClickedMessage,
//                            fourthAgreeButtonClickedMessage: fourthAgreeClickedMessage,
//                            nextButtonClicked: nextButtonClicked)
//
//        action(output)
//
//        input.navButtonTapped
//            .drive(onNext: { _ in
//                AuthStepper.shared.steps.accept(MGStep.authBack)
//            }).disposed(by: disposeBag)
//        
//        input.firstSeeMoreButtonTap
//            .drive(onNext: { _ in
//                print("sex")
//
//            }).disposed(by: disposeBag)
//        
//
//        return output
//    }
//}

import Foundation
import RxSwift
import RxCocoa
import RxFlow

import Core
import Domain
import SafariServices

public class AgreeViewModel: BaseViewModel {

    public typealias ViewModel = AgreeViewModel

    private let useCase: AuthUseCase
    private let disposeBag = DisposeBag()

    public struct Input {
        let navButtonTapped: Driver<Void>
        let allAgreeButtonTap: Signal<Void>
        let firstAgreeButtonTap: Signal<Void>
        let firstSeeMoreButtonTap: Driver<Void>
        let secondAgreeButtonTap: Signal<Void>
        let secondSeeMoreButtonTap: Single<Void>
        let thirdAgreeButtonTap: Signal<Void>
        let fourthAgreeButtonTap: Signal<Void>
        let nextButtonTap: Signal<Void>
    }

    public struct Output {
        let navButtonTapped: Driver<Void>
        let allAgreeButtonClickedMessage: Observable<String>
        let firstAgreeButtonClickedMessage: Observable<String>
        let secondAgreeButtonClickedMessage: Observable<String>
        let thirdAgreeButtonClickedMessage: Observable<String>
        let fourthAgreeButtonClickedMessage: Observable<String>
        let nextButtonClicked: Driver<Bool>
    }

    public init(useCase: AuthUseCase) {
        self.useCase = useCase
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let output = createOutput(from: input)
        action(output)
        handleSideEffects(input)
        return output
    }

    private func createOutput(from input: Input) -> Output {
        Output(
            navButtonTapped: input.navButtonTapped.asDriver(),
            allAgreeButtonClickedMessage: createMessageObservable(for: input.allAgreeButtonTap, message: "전체 클릭"),
            firstAgreeButtonClickedMessage: createMessageObservable(for: input.firstAgreeButtonTap, message: "첫 번째 동의 클릭"),
            secondAgreeButtonClickedMessage: createMessageObservable(for: input.secondAgreeButtonTap, message: "두 번째 동의 클릭"),
            thirdAgreeButtonClickedMessage: createMessageObservable(for: input.thirdAgreeButtonTap, message: "세 번째 동의 클릭"),
            fourthAgreeButtonClickedMessage: createMessageObservable(for: input.fourthAgreeButtonTap, message: "네 번째 동의 클릭"),
            nextButtonClicked: input.nextButtonTap.map { true }.asDriver(onErrorJustReturn: false)
        )
    }

    private func createMessageObservable(for signal: Signal<Void>, message: String) -> Observable<String> {
        signal.map { message }.asObservable()
    }

    private func handleSideEffects(_ input: Input) {
        input.navButtonTapped
            .drive(onNext: { _ in
                AuthStepper.shared.steps.accept(MGStep.authBack)
            }).disposed(by: disposeBag)

        input.firstSeeMoreButtonTap
            .drive(onNext: { _ in
                print("클릭")
            }).disposed(by: disposeBag)
    }
}
