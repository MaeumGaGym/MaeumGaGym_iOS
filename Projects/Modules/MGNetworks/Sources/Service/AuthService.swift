import UIKit

import RxSwift
import RxCocoa

import RxMoya
import Moya

import DSKit
import TokenManager
import Domain

import MGLogger
import KakaoSDKUser
import KakaoSDKAuth

import AuthenticationServices

public class AuthService: NSObject {

    let kakaoProvider = MoyaProvider<KakaoAPI>()
    let googleProvider = MoyaProvider<GoogleAPI>()
    let appleProvider = MoyaProvider<AppleAPI>()
    let authProvider = MoyaProvider<AuthAPI>()

    private let keychainAuthorization = KeychainType.authorizationToken
    private let appleSignupSubject = PublishSubject<String>()
    
    public func nicknameCheck(nickname: String) -> Single<Response> {
        return authProvider.rx.request(.nickname(nickname: nickname))
            .filterSuccessfulStatusCodes()
    }

    public func oauthSingup(nickname: String, accessToken: String, oauth: OauthType) -> Single<Response> {
        switch oauth {
        case .google:
            return googleSignup(nickname: nickname, accessToken: accessToken)
        case .kakao:
            return kakaoSignup(nickname: nickname, accessToken: accessToken)
        case .apple:
            return appleSignup(nickname: nickname, accessToken: accessToken)
        }
    }

//    public func oauthLogin(accessToken: String, oauth: OauthType) -> Observable<String> {
//        switch oauth {
//        case .google:
//            return googleLogin(accessToken: accessToken)
//        case .kakao:
//            return kakaoLogin(accessToken: accessToken)
//        case .apple:
//            return appleLogin(accessToken: accessToken)
//        }
//    }
    
    public func oauthLogin(accessToken: String, oauth: OauthType) -> Single<Response> {
        switch oauth {
        case .google:
            return googleLogin(accessToken: accessToken)
        case .kakao:
            return kakaoLogin(accessToken: accessToken)
        case .apple:
            return appleLogin(accessToken: accessToken)
        }
    }

    public func oauthRecovery(accessToken: String, oauth: OauthType) -> Single<Response> {
        switch oauth {
        case .google:
            return googleRecovery(accessToken: accessToken)
        case .kakao:
            return kakaoRecovery(accessToken: accessToken)
        case .apple:
            return appleRecovery(accessToken: accessToken)
        }
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
        return Single.just(IntroModel(image: DSKitAsset.Assets.airSqt.image, mainTitle: "이제 헬창이 되어보세요!", subTitle: "저희의 좋은 서비스를 통해 즐거운 생활을\n즐겨보세요!"))
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

private extension AuthService {
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
        return kakaoProvider.rx.request(.kakaoSignup(nickname: nickname, accessToken: accessToken))
    }

    func kakaoLogin(accessToken: String) -> Single<Response> {
        return kakaoProvider.rx.request(.kakaoLogin(accessToken: accessToken))
    }

    func kakaoRecovery(accessToken: String) -> Single<Response> {
        return kakaoProvider.rx.request(.kakaoRecovery(accessToken: accessToken))
    }

    func appleSignup(nickname: String, accessToken: String) -> Single<Response> {
        return appleProvider.rx.request(.appleSignup(nickname: nickname, accessToken: accessToken))
    }

    func appleLogin(accessToken: String) -> Single<Response> {
        return appleProvider.rx.request(.appleLogin(accessToken: accessToken))
    }

    func appleRecovery(accessToken: String) -> Single<Response> {
        return appleProvider.rx.request(.appleRecovery(accessToken: accessToken))
    }

    //    public func appleTokenState() -> Single<Bool> {
    //        return Single.create { [weak self] single in
                
    //        }
    //    }
}
