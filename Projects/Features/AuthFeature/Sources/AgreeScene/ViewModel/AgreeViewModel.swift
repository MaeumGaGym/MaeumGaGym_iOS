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
        let nextButtonClickedMessage: Driver<String>
    }
    
    public func transform(_ input: Input) -> Output {
        let allAgreeClickedMessage = input.allAgreeButtonTap.map {
            return "전체 클릭"
        }
        .asDriver(onErrorJustReturn: "")
        
        let firstAgreeClickedMessage = input.firstAgreeButtonTap.map {
            return "구글버튼 클릭"
        }
        .asDriver(onErrorJustReturn: "")
        
        let secondAgreeClickedMessage = input.secondAgreeButtonTap.map {
            return "애플버튼 클릭"
        }
        .asDriver(onErrorJustReturn: "")
        
        let thirdAgreeClickedMessage = input.thirdAgreeButtonTap.map {
            return "전체 클릭"
        }
        .asDriver(onErrorJustReturn: "")
        
        let fourthAgreeClickedMessage = input.fourthAgreeButtonTap.map {
            return "구글버튼 클릭"
        }
        .asDriver(onErrorJustReturn: "")
        
        let nextClickedMessage = input.nextButtonTap.map {
            return "애플버튼 클릭"
        }
        .asDriver(onErrorJustReturn: "")
        
        return Output(
            allAgreeButtonClickedMessage: allAgreeClickedMessage, firstAgreeButtonClickedMessage: firstAgreeClickedMessage, secondAgreeButtonClickedMessage: secondAgreeClickedMessage, thirdAgreeButtonClickedMessage: thirdAgreeClickedMessage, fourthAgreeButtonClickedMessage: fourthAgreeClickedMessage, nextButtonClickedMessage: nextClickedMessage
        )
    }
    
    public init() {
        
    }
    
}
