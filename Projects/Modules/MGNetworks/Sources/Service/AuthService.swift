import UIKit

import RxSwift
import RxCocoa

import RxMoya
import Moya

import DSKit
import TokenManager
import Domain

import KakaoSDKUser
import AuthenticationServices

public class AuthService: NSObject {

    let kakaoProvider = MoyaProvider<KakaoAPI>()
    let googleProvider = MoyaProvider<GoogleAPI>()
    let appleProvider = MoyaProvider<AppleAPI>()

    private let keychainAuthorization = KeychainType.authorizationToken
    private let appleSignupSubject = PublishSubject<String>()

    public func oauthSingup(nickname: String, accessToken: String, oauth: OauthType) -> Observable<String> {
        switch oauth {
        case .google:
            return googleSignup(nickname: nickname, accessToken: accessToken)
        case .kakao:
            return kakaoSignup(nickname: nickname, accessToken: accessToken)
        case .apple:
            return appleSignup(nickname: nickname, accessToken: accessToken)
        }
    }

    public func oauthLogin(accessToken: String, oauth: OauthType) -> Observable<String> {
        switch oauth {
        case .google:
            return googleLogin(accessToken: accessToken)
        case .kakao:
            return kakaoLogin(accessToken: accessToken)
        case .apple:
            return appleLogin(accessToken: accessToken)
        }
    }

    public func oauthRecovery(accessToken: String, oauth: OauthType) -> Observable<String> {
        switch oauth {
        case .google:
            return googleRecovery(accessToken: accessToken)
        case .kakao:
            return kakaoRecovery(accessToken: accessToken)
        case .apple:
            return appleRecovery(accessToken: accessToken)
        }
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
                oauthLogin(accessToken: tokenString, oauth: .apple)
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
    func googleSignup(nickname: String, accessToken: String) -> Observable<String> {
        return googleProvider.rx.request(.googleSignup(nickname: nickname, accessToken: accessToken)).mapString().asObservable()
    }

    func googleLogin(accessToken: String) -> Observable<String> {
        return googleProvider.rx.request(.googleLogin(accessToken: accessToken)).mapString().asObservable()
    }

    func googleRecovery(accessToken: String) -> Observable<String> {
        return googleProvider.rx.request(.googleRecovery(accessToken: accessToken))
            .mapString().asObservable()
    }

    func kakaoSignup(nickname: String, accessToken: String) -> Observable<String> {
        return kakaoProvider.rx.request(.kakaoSignup(nickname: nickname, accessToken: accessToken))
            .mapString().asObservable()
    }

    func kakaoLogin(accessToken: String) -> Observable<String> {
        return kakaoProvider.rx.request(.kakaoLogin(accessToken: accessToken)).mapString().asObservable()
    }

    func kakaoRecovery(accessToken: String) -> Observable<String> {
        return kakaoProvider.rx.request(.kakaoRecovery(accessToken: accessToken))
            .mapString().asObservable()
    }

    func appleSignup(nickname: String, accessToken: String) -> Observable<String> {
        return appleProvider.rx.request(.appleSignup(nickname: nickname, accessToken: accessToken))
            .mapString().asObservable()
    }

    func appleLogin(accessToken: String) -> Observable<String> {
        return appleProvider.rx.request(.appleLogin(accessToken: accessToken))
            .mapString().asObservable()
    }

    func appleRecovery(accessToken: String) -> Observable<String> {
        return appleProvider.rx.request(.appleRecovery(accessToken: accessToken))
            .mapString().asObservable()
    }

    //    public func appleTokenState() -> Single<Bool> {
    //        return Single.create { [weak self] single in
                
    //        }
    //    }
}
