import UIKit
import AuthenticationServices

import RxSwift
import RxCocoa

import RxMoya
import Moya

import Domain
import DSKit
import TokenManager

import KakaoSDKUser

public class AuthService: NSObject {

//    GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
//        if let error = error { return }
//        guard let user = user else { return }
//     
//        print(user)
//    }
    
    let provider = MoyaProvider<CsrfAPI>()
    let kakaoProvider = MoyaProvider<KakaoAPI>()
    
    let googleProvider = MoyaProvider<GoogleAPI>()
    
    public func googleSignup(nickname: String, accessToken: String) -> Single<String> {
        return googleProvider.rx.request(.googleSignup(nickname: nickname, accessToken: accessToken))
            .mapString()
    }
    
    public func googleLogin() -> Single<String> {
        return googleProvider.rx.request(.googleLogin)
            .mapString()
    }
    
//    public func googleTokenState() -> Single<Bool> {
//        return Single.create { [weak self] single in
            
//        }
//    }
    
    private let keychainAuthorization = KeychainType.authorizationToken
    private let appleSignupSubject = PublishSubject<String>()
    
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
        return Single.just(IntroModel(image: DSKitAsset.Assets.airSqt.image, mainTitle: "이제 헬창이 되어보세요!", subTitle: "저희의 좋은 서비스를 통해 즐거운 생활을\n즐겨보세요!"))
    }
    
    public func appleSignup() -> Single<String> {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.performRequests()
        
        controller.delegate = self
        
        return appleSignupSubject.take(1).asSingle()
    }
    
    public override init() {
        
    }
}

extension AuthService: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController,
                                        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            if let identityToken = appleIDCredential.identityToken,
               let tokenString = String(data: identityToken, encoding: .utf8) {
                appleSignupSubject.onNext(tokenString)
                appleSignupSubject.onCompleted()
            }
        default:
            break
        }
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        appleSignupSubject.onError(error)
    }
}
