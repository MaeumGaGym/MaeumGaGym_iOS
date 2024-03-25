import UIKit

import RxSwift
import RxCocoa
import Moya

public enum OauthType {
    case google
    case kakao
    case apple
}

public protocol AuthRepositoryInterface {
    func googleToken() -> Single<Bool>
    func kakaoToken() -> Single<Bool>
    func appleToken() -> Single<Bool>
    func appleButtonTap() -> Single<String>
    func oauthSignup(nickname: String, accessToken: String, oauth: OauthType) -> Observable<Response>
    func oauthLogin(accessToken: String, oauth: OauthType) -> Single<Response>
    func oauthRecovery(accessToken: String, oauth: OauthType) -> Observable<Response>
    func getIntroData() -> Single<IntroModel>
}
