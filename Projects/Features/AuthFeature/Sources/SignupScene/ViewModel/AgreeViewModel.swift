import Foundation

import RxFlow
import RxCocoa
import RxSwift

import Core

public class AgreeViewModel: BaseViewModel {

    public struct Input {
        let allAgreeButtonTap: Signal<Void>
        let firstAgreeButtonTap: Signal<Void>
        let secondAgreeButtonTap: Signal<Void>
        let thirdAgreeButtonTap: Signal<Void>
        let fourthAgreeButtonTap: Signal<Void>
        let nextButtonTap: Signal<Void>
    }
    
    public struct Output {
        let allAgreeButtonClickedMessage: Driver<String>
        let firstAgreeButtonClickedMessage: Driver<String>
        let secondAgreeButtonClickedMessage: Driver<String>
        let thirdAgreeButtonClickedMessage: Driver<String>
        let fourthAgreeButtonClickedMessage: Driver<String>
        let nextButtonClicked: Driver<Bool>
    }

    public init() {

    }
    
    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        let allAgreeClickedMessage = input.allAgreeButtonTap.map { "전체 클릭" }.asDriver(onErrorJustReturn: "")
        let firstAgreeClickedMessage = input.firstAgreeButtonTap.map { "첫 번째 동의 클릭" }.asDriver(onErrorJustReturn: "")
        let secondAgreeClickedMessage = input.secondAgreeButtonTap.map { "두 번째 동의 클릭" }.asDriver(onErrorJustReturn: "")
        let thirdAgreeClickedMessage = input.thirdAgreeButtonTap.map { "세 번째 동의 클릭" }.asDriver(onErrorJustReturn: "")
        let fourthAgreeClickedMessage = input.fourthAgreeButtonTap.map { "네 번째 동의 클릭" }.asDriver(onErrorJustReturn: "")
        let nextButtonClicked = input.nextButtonTap.map { true }.asDriver(onErrorJustReturn: false)

        return Output(
            allAgreeButtonClickedMessage: allAgreeClickedMessage,
            firstAgreeButtonClickedMessage: firstAgreeClickedMessage,
            secondAgreeButtonClickedMessage: secondAgreeClickedMessage,
            thirdAgreeButtonClickedMessage: thirdAgreeClickedMessage,
            fourthAgreeButtonClickedMessage: fourthAgreeClickedMessage,
            nextButtonClicked: nextButtonClicked
        )
    }
}
