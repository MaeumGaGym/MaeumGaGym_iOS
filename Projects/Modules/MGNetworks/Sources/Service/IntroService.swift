import UIKit

import RxSwift
import RxCocoa

import RxMoya
import Moya

import Domain
import DSKit
import AuthenticationServices

import MGLogger

public class IntroService: NSObject {
    
    let provider = MoyaProvider<CsrfAPI>()
    
    private let appleLoginSubject = PublishSubject<String>()
    
    public func requestToken() -> Single<Bool> {
        return Single.just(true)
    }
    
    public func kakaoTokenState(access_token: String) -> Single<String> {
        return Single.deferred {
            return Single.create { single in
                let result = access_token
                
                single(.success(result))
                
                return Disposables.create()
            }
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
    
    public func appleLogin() -> Single<String> {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.performRequests()

        controller.delegate = self

        return appleLoginSubject.take(1).asSingle()
    }
    
    public override init() {
        
    }
}

extension IntroService: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController,
                                        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            if let identityToken = appleIDCredential.identityToken,
               let tokenString = String(data: identityToken, encoding: .utf8) {
                appleLoginSubject.onNext(tokenString)
                appleLoginSubject.onCompleted()
            }
        default:
            break
        }
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        appleLoginSubject.onError(error)
    }
}
