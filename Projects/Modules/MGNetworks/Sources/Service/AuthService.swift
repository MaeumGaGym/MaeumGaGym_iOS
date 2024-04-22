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

public protocol AuthService {
    func nicknameCheck(param: CheckNicknameRequestDTO) -> Single<CheckNicknameResponseDTO>
    func tokenRefresh(param: TokenRefreshRequestDTO) -> Single<TokenRefreshResponseDTO>
    func oauthSingup(param: SignupRequestDTO, oauth: OauthType) -> Single<SignupResponseDTO>
    func oauthLogin(param: LoginRequestDTO, oauth: OauthType) -> Single<LoginResponseDTO>
    func oauthRecovery(param: RecoveryRequestDTO, oauth: OauthType) -> Single<RecoveryResponseDTO>
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

    private let keychainAuthorization = KeychainType.authorizationToken
    private let appleSignupSubject = PublishSubject<String>()
}

extension DefaultAuthService: AuthService {
    public func nicknameCheck(param: CheckNicknameRequestDTO) -> Single<CheckNicknameResponseDTO> {
        return authProvider.rx.request(.checkNickname(param: param)).map(CheckNicknameResponseDTO.self)
    }
        public func tokenRefresh(param: TokenRefreshRequestDTO) -> Single<TokenRefreshResponseDTO> {
        return authProvider.rx.request(.reissuanceToken(refreshToken: param.refreshToken))
                .filterSuccessfulStatusCodes()
                .map(TokenRefreshResponseDTO.self)
    }

    public func oauthSingup(param: SignupRequestDTO, oauth: OauthType) -> Single<SignupResponseDTO> {
        switch oauth {
        case .google:
            return googleSignup(param: param)
        case .kakao:
            return kakaoSignup(param: param)
        case .apple:
            return appleSignup(param: param)
        }
    }

    public func oauthLogin(param: LoginRequestDTO, oauth: OauthType) -> Single<LoginResponseDTO> {
        switch oauth {
        case .google:
            return googleLogin(param: param)
        case .kakao:
            return kakaoLogin(param: param)
        case .apple:
            return appleLogin(param: param)
        }
    }

    public func oauthRecovery(param: RecoveryRequestDTO, oauth: OauthType) -> Single<RecoveryResponseDTO> {
        switch oauth {
        case .google:
            return googleRecovery(param: param)
        case .kakao:
            return kakaoRecovery(param: param)
        case .apple:
            return appleRecovery(param: param)
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
    func googleSignup(param: SignupRequestDTO) -> Single<SignupResponseDTO> {
        return googleProvider.rx.request(.googleSignup(param: param))
            .map(SignupResponseDTO.self)
    }

    func googleLogin(param: LoginRequestDTO) -> Single<LoginResponseDTO> {
        return googleProvider.rx.request(.googleLogin(param: param)).map(LoginResponseDTO.self)
    }

    func googleRecovery(param: RecoveryRequestDTO) -> Single<RecoveryResponseDTO> {
        return googleProvider.rx.request(.googleRecovery(param: param)).map(RecoveryResponseDTO.self)
    }

    func kakaoSignup(param: SignupRequestDTO) -> Single<SignupResponseDTO> {
        return kakaoProvider.rx.request(.kakaoSignup(param: param)).map(SignupResponseDTO.self)
    }

    func kakaoLogin(param: LoginRequestDTO) -> Single<LoginResponseDTO> {
        return kakaoProvider.rx.request(.kakaoLogin(param: param)).map(LoginResponseDTO.self)
    }

    func kakaoRecovery(param: RecoveryRequestDTO) -> Single<RecoveryResponseDTO> {
        return kakaoProvider.rx.request(.kakaoRecovery(param: param)).map(RecoveryResponseDTO.self)
    }

    func appleSignup(param: SignupRequestDTO) -> Single<SignupResponseDTO> {
        return appleProvider.rx.request(.appleSignup(param: param))
            .filterSuccessfulStatusCodes()
            .map(SignupResponseDTO.self)
    }

    func appleLogin(param: LoginRequestDTO) -> Single<LoginResponseDTO> {
        return appleProvider.rx.request(.appleLogin(param: param))
            .filterSuccessfulStatusCodes()
            .map(LoginResponseDTO.self)
    }

    func appleRecovery(param: RecoveryRequestDTO) -> Single<RecoveryResponseDTO> {
        return appleProvider.rx.request(.appleRecovery(param: param))
        .filterSuccessfulStatusCodes()
        .map(RecoveryResponseDTO.self)
    }
}
