import UIKit

import RxSwift
import RxCocoa

import RxMoya
import Moya

import DSKit
import Domain
import TokenManager

import MGLogger
import KakaoSDKUser
import KakaoSDKAuth

import AuthenticationServices

public protocol AuthService {
    func nicknameCheck(nickname: String) -> Single<Response>
    func oauthLogin(accessToken: String, oauth: OauthType) -> Single<Response>
    func oauthSingup(nickname: String, accessToken: String, oauth: OauthType) -> Single<Response>
    func oauthRecovery(accessToken: String, oauth: OauthType) -> Single<Response>
    func tokenReIssue(refreshToken: String) -> Single<Response>
    func kakaoButtonTap() -> Single<OAuthToken?>
    func requestToken() -> Single<Bool>
    func requestIntroData() -> Single<IntroModel>
    func appleButtonTap() -> Single<String>
}

public class DefaultAuthService: NSObject {
    let kakaoProvider = MoyaProvider<KakaoAPI>()
    let googleProvider = MoyaProvider<GoogleAPI>()
    let appleProvider = MoyaProvider<AppleAPI>()
    let authProvider = MoyaProvider<AuthAPI>()
    
    private let appleSignupSubject = PublishSubject<String>()
}

extension DefaultAuthService: AuthService {
    
    public func nicknameCheck(nickname: String) -> Single<Response> {
        return authProvider.rx.request(.nickname(nickname: nickname)).filterSuccessfulStatusCodes()
    }
    
    public func oauthSingup(nickname: String, accessToken: String, oauth: OauthType) -> Single<Response> {
        switch oauth {
        case .google:
            return googleSignup(nickname: nickname, accessToken: accessToken)
        case .kakao:
            return kakaoSignup(nickname: nickname, accessToken: accessToken)
        case .apple:
            return appleSignup(nickname: nickname, oauthToken: accessToken)
        }
    }
    
    public func oauthLogin(accessToken: String, oauth: OauthType) -> Single<Response> {
        switch oauth {
        case .google:
            return googleLogin(accessToken: accessToken)
        case .kakao:
            return kakaoLogin(accessToken: accessToken)
        case .apple:
            return appleLogin(oauthToken: accessToken)
        }
    }
    
    public func oauthRecovery(accessToken: String, oauth: OauthType) -> Single<Response> {
        switch oauth {
        case .google:
            return googleRecovery(accessToken: accessToken)
        case .kakao:
            return kakaoRecovery(accessToken: accessToken)
        case .apple:
            return appleRecovery(oauthToken: accessToken)
        }
    }

    public func tokenReIssue(refreshToken: String) -> Single<Response> {
        return authProvider.rx.request(.reissuanceToken(refreshToken: refreshToken))
    }

    public func kakaoButtonTap() -> Single<OAuthToken?> {
        return Single.create { single in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                    if let oauthToken = oauthToken {
                        single(.success(oauthToken))
                    } else {
                        single(.success(nil))
                    }
                }
            } else {
                single(.success(nil))
            }
            return Disposables.create()
        }
    }

    public func requestToken() -> Single<Bool> {
        return Single.just(true)
    }
    
    public func requestIntroData() -> Single<IntroModel> {
        return Single.just(IntroModel(image: DSKitAsset.Assets.airSqt.image, mainTitle: "이제 운동을 시작해 보세요!", subTitle: "저희의 좋은 서비스를 통해 즐거운 생활을\n즐겨보세요!"))
    }
    
    public func appleButtonTap() -> Single<String> {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.performRequests()
        
        controller.delegate = self
        
        return appleSignupSubject.take(1).asSingle()
    }
}

extension DefaultAuthService: ASAuthorizationControllerDelegate {
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

private extension DefaultAuthService {
    func googleSignup(nickname: String, accessToken: String) -> Single<Response> {
        return googleProvider.rx.request(.googleSignup(nickname: nickname, accessToken: accessToken))
    }
    
    func googleLogin(accessToken: String) -> Single<Response> {
        return googleProvider.rx.request(.googleLogin(accessToken: accessToken))
    }
    
    func googleRecovery(accessToken: String) -> Single<Response> {
        return googleProvider.rx.request(.googleRecovery(accessToken: accessToken))
    }
    
    func kakaoSignup(nickname: String, accessToken: String) -> Single<Response> {
        return kakaoProvider.rx.request(.kakaoSignup(nickname: nickname, oauthToken: accessToken))
    }
    
    func kakaoLogin(accessToken: String) -> Single<Response> {
        return kakaoProvider.rx.request(.kakaoLogin(oauthToken: accessToken))
    }
    
    func kakaoRecovery(accessToken: String) -> Single<Response> {
        return kakaoProvider.rx.request(.kakaoRecovery(oauthToken: accessToken))
    }
    
    func appleSignup(nickname: String, oauthToken: String) -> Single<Response> {
        return appleProvider.rx.request(.appleSignup(nickname: nickname, oauthToken: oauthToken))
    }
    
    func appleLogin(oauthToken: String) -> Single<Response> {
        return appleProvider.rx.request(.appleLogin(oauthToken: oauthToken))
    }
    
    func appleRecovery(oauthToken: String) -> Single<Response> {
        return appleProvider.rx.request(.appleRecovery(oauthToken: oauthToken))
    }
}
