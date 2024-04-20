import UIKit
import MGNetworks

import RxSwift
import RxCocoa

import Moya
import RxMoya

import Domain
import KakaoSDKAuth

public class AuthRepository: AuthRepositoryInterface {

    private let networkService: AuthService

    public func oauthSignup(param: SignupRequestDTO, oauth: OauthType) -> Single<SignupResponseDTO> {
        return networkService.oauthSingup(param: param, oauth: oauth)
    }

    public func oauthLogin(param: LoginRequestDTO, oauth: OauthType) -> Single<LoginResponseDTO> {
        return networkService.oauthLogin(param: param, oauth: oauth)
    }
    
    public func oauthRecovery(param: RecoveryRequestDTO, oauth: OauthType) -> Single<RecoveryResponseDTO> {
        return networkService.oauthRecovery(param: param, oauth: oauth)
    }
    
    public func nicknameCheck(param: CheckNicknameRequestDTO) -> Single<CheckNicknameResponseDTO> {
        return networkService.nicknameCheck(param: param)
    }

    public func getIntroData() -> Single<IntroModel>  {
        return networkService.requestIntroData()
    }

    public func appleButtonTap() -> Single<String> {
        return networkService.appleButtonTap()
    }
    
    public func kakaoButtonTap() -> Single<OAuthToken?> {
        return networkService.kakaoButtonTap()
    }
    
    public func tokenRefresh(param: TokenRefreshRequestDTO) -> Single<TokenRefreshResponseDTO> {
        return networkService.tokenRefresh(param: param)
    }

    public init(networkService: AuthService) {
        self.networkService = networkService
    }



//    public func appleSingup(nickname: String, accessToken: String) -> Single<String> {
//        return networkService.appleSignup(nickname: nickname, accessToken: accessToken)
//    }
}
