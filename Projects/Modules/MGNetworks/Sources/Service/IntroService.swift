import UIKit

import RxSwift
import RxCocoa

import RxMoya
import Moya

import Domain
import DSKit
import KakaoSDKUser
import TokenManager

public class IntroService {
    
    let provider = MoyaProvider<CsrfAPI>()
    let kakaoProvider = MoyaProvider<KakaoAPI>()
    
    private let keychainAuthorization = KeychainType.authorizationToken
    
    public func requestToken() -> Single<Bool> {
        return Single.just(true)
    }
    
    public func kakaoLogin() -> Single<String> {
        return kakaoProvider.rx.request(.kakaoLogin)
            .mapString()
    }

    public func kakaoSignup(nickname: String, accessToken: String) -> Single<String> {
        return kakaoProvider.rx.request(.kakaoSignup(nickname: nickname, accessToken: accessToken))
            .mapString()
    }

    public func kakaoRecovery() -> Single<String> {
        return kakaoProvider.rx.request(.kakaoRecovery)
            .mapString()
    }
    
    public func kakaoTokenState() -> Single<Bool> {
        return Single.create { [weak self] single in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                    if let error = error {
                        single(.success(false))
                    } else {
                        guard let self = self, let accessToken = oauthToken?.accessToken else {
                            single(.success(false))
                            return
                        }
                        if TokenManagerImpl().save(token: accessToken, with: self.keychainAuthorization) {
                            single(.success(true))
                        } else {
                            single(.success(false))
                        }
                    }
                }
            } else {
                single(.success(false))
            }
            return Disposables.create()
        }
    }
    
    public func getCSRFToken() -> Single<String> {
        return provider.rx.request(.getCSRFToken)
            .flatMap { response -> Single<String> in
                if let setCookieHeader = response.response?.allHeaderFields["Set-Cookie"] as? String {
                    let cookies = setCookieHeader.components(separatedBy: ", ")
                    for cookie in cookies {
                        if cookie.hasPrefix("XSRF-TOKEN") {
                            let token = cookie.components(separatedBy: "=")[1].components(separatedBy: ";")[0]
                            return Single.just(token)
                        }
                    }
                }
                return Single.error(AuthError.tokenNotFound)
            }
    }
    
    public func requestIntroData() -> Single<IntroModel> {
        return Single.just(IntroModel(image: DSKitAsset.Assets.blueHome.image, mainTitle: "이제 헬창이 되어보세요!", subTitle: "저희의 좋은 서비스를 통해 즐거운 생활을\n즐겨보세요!"))
    }
    
    public init() {
        
    }
    
}
