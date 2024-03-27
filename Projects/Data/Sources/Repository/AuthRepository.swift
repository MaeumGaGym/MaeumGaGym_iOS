import UIKit
import MGNetworks

import RxSwift
import RxCocoa

import Moya
import RxMoya

import Domain

public class AuthRepository: AuthRepositoryInterface {

    private let networkService: AuthService

    public func googleToken() -> Single<Bool> {
        return networkService.kakaoTokenState()
    }

    public func kakaoToken() -> Single<Bool> {
        return networkService.kakaoTokenState()
    }

    public func appleToken() -> Single<Bool> {
        return networkService.kakaoTokenState()
    }

    public func oauthSignup(nickname: String, accessToken: String, oauth: OauthType) -> Single<Response> {
        return networkService.oauthSingup(nickname: nickname, accessToken: accessToken, oauth: oauth)
    }

    public func oauthLogin(accessToken: String, oauth: OauthType) -> Single<Response> {
        return networkService.oauthLogin(accessToken: accessToken, oauth: oauth)
    }
    
    public func oauthRecovery(accessToken: String, oauth: OauthType) -> Single<Response> {
        return networkService.oauthRecovery(accessToken: accessToken, oauth: oauth)
    }
    
    public func nicknameCheck(nickname: String) -> Single<Response> {
        return networkService.nicknameCheck(nickname: nickname)
    }

    public func getIntroData() -> Single<IntroModel>  {
        return networkService.requestIntroData()
    }

    public func appleButtonTap() -> Single<String> {
        return networkService.appleButtonTap()
    }

    public init(networkService: AuthService) {
        self.networkService = networkService
    }

//    public func appleSingup(nickname: String, accessToken: String) -> Single<String> {
//        return networkService.appleSignup(nickname: nickname, accessToken: accessToken)
//    }
}
