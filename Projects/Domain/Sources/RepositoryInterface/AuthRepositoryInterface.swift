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
    func oauthSignup(param: SignupRequestDTO, oauth: OauthType) -> Single<SignupResponseDTO>
    func oauthLogin(param: LoginRequestDTO, oauth: OauthType) -> Single<LoginResponseDTO>
    func oauthRecovery(param: RecoveryRequestDTO, oauth: OauthType) -> Single<RecoveryResponseDTO>
    func nicknameCheck(param: CheckNicknameRequestDTO) -> Single<CheckNicknameResponseDTO>
    func getIntroData() -> Single<IntroModel>
    func tokenRefresh(param: TokenRefreshRequestDTO) -> Single<TokenRefreshResponseDTO>
}
