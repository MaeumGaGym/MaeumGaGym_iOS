import UIKit

import RxSwift
import RxCocoa
import Moya

import KakaoSDKAuth

public enum OauthType {
    case google
    case kakao
    case apple
}

public protocol AuthRepositoryInterface {
    func kakaoButtonTap() -> Single<OAuthToken?>
    func appleButtonTap() -> Single<String>
    func oauthSignup(nickname: String, accessToken: String, oauth: OauthType) -> Single<Response>
    func oauthLogin(accessToken: String, oauth: OauthType) -> Single<Response>
    func oauthRecovery(accessToken: String, oauth: OauthType) -> Single<Response>
    func tokenReIssue(refreshToken: String) -> Single<Response>
    func nicknameCheck(nickname: String) -> Single<Response>
    func getIntroData() -> Single<IntroModel>
}
