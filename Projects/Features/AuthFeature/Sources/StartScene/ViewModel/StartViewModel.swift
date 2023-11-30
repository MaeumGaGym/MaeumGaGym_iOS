import Foundation
import RxFlow
import RxCocoa
import RxSwift
import Core

public class StartViewModel: BaseViewModel {
    
    public struct Input {
        let kakaoButtonTap: Observable<Void>
        let googleButtonTap: Observable<Void>
        let appleButtonTap: Observable<Void>
    }
    
    public struct Output {
        let kakaoClickedMessage: Driver<String>
        let googleClickedMessage: Driver<String>
        let appleClickedMessage: Driver<String>
    }
    
    public func transform(_ input: Input) -> Output {
        let kakaoClickedMessage = input.kakaoButtonTap.map {
            return "카카오버튼 클릭"
        }
        .asDriver(onErrorJustReturn: "")
        
        let googleClickedMessage = input.googleButtonTap.map {
            return "구글버튼 클릭"
        }
        .asDriver(onErrorJustReturn: "")
        
        let appleClickedMessage = input.appleButtonTap.map {
            return "애플버튼 클릭"
        }
        .asDriver(onErrorJustReturn: "")
        
        return Output(
            kakaoClickedMessage: kakaoClickedMessage,
            googleClickedMessage: googleClickedMessage,
            appleClickedMessage: appleClickedMessage
        )
    }
    
    public init() {
        
    }
}
