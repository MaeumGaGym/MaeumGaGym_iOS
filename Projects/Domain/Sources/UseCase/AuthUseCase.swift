import UIKit

import RxSwift
import RxCocoa

import Core
import Moya

import MGLogger
import TokenManager
import AuthenticationServices

public protocol AuthUseCase {
    func splashLogin()
    func kakaoButtonTap()
    func getIntroData()
    func appleButtonTap()
    func changeNickname(nickname: String)
    func nextButtonTap()
    var appleSignupResult: PublishSubject<String> { get }
    var introData: PublishSubject<IntroModel> { get }
}

public class DefaultAuthUseCase {
    private let authRepository: AuthRepositoryInterface
    private let disposeBag = DisposeBag()
    
    open var oauthType: OauthType = .kakao
    public var nicknameText: String = ""
    
    public let introData = PublishSubject<IntroModel>()
    public let appleSignupResult = PublishSubject<String>()
    public let appleNicknameSignupResult = PublishSubject<String>()

    public init(authRepository: AuthRepositoryInterface) {
        self.authRepository = authRepository
    }
}

extension DefaultAuthUseCase: AuthUseCase {

    public func changeNickname(nickname: String) {
        self.nicknameText = nickname
    }

    public func splashLogin() {
        guard let refreshToken = TokenManagerImpl().get(key: .refreshToken) else {
            AuthStepper.shared.steps.accept(MGStep.authIntroIsRequired)
            return
        }

        authRepository.tokenRefresh(param: TokenRefreshRequestDTO(refreshToken: refreshToken))
            .subscribe(onSuccess: { response in
                if response.status >= 400 {
                    MGLogger.debug("RF - token test ❌ \(response)")
                    AuthStepper.shared.steps.accept(MGStep.authIntroIsRequired)
                } else if response.status >= 200 && response.status < 300 {
                    MGLogger.debug("RF - token test ✅ \(response)")
                    AuthStepper.shared.steps.accept(MGStep.initialization)
                }
            }, onFailure: { error in
                MGLogger.debug("RF - token test 여기? ❌ \(error)")
                AuthStepper.shared.steps.accept(MGStep.authIntroIsRequired)
            }).disposed(by: disposeBag)
    }

    public func kakaoButtonTap() {
        oauthType = .kakao
        authRepository.kakaoButtonTap().subscribe(onSuccess: { [self] token in
            let oauthToken = token!.accessToken
            MGLogger.debug("kakaoButtonTap token ✅ \(oauthToken)")
            TokenManagerImpl().save(token: oauthToken, with: .oauthToken)
            authRepository.oauthLogin(param: LoginRequestDTO(oauthToken: oauthToken), oauth: .kakao)
                .flatMap { response -> Single<LoginResponseDTO> in
                    if response.status >= 400 {
                        return Single.error(AuthErrorType.notFound400)
                    } else {
                        return Single.just(response)
                    }
                }
                .subscribe(onSuccess: { element in
                    MGLogger.debug("appleButtonTap login ✅ \(element)")
                    TokenManagerImpl().save(token: element.accessToken, with: .authorizationToken)
                    TokenManagerImpl().save(token: element.refreshToken, with: .refreshToken)
                    AuthStepper.shared.steps.accept(MGStep.initialization)
                }, onFailure: { [self] error in
                    MGLogger.debug("appleButtonTap login ❌ \(error)")
                    authRepository.oauthRecovery(param: RecoveryRequestDTO(oauthToken: oauthToken), oauth: .kakao)
                        .flatMap { response -> Single<RecoveryResponseDTO> in
                            if response.status >= 400 {
                                return Single.error(AuthErrorType.notFound400)
                            } else {
                                return Single.just(response)
                            }
                        }
                        .subscribe(onSuccess: { [self] element in
                            MGLogger.debug("appleButtonTap recovery ✅ \(element)")
                            authRepository.oauthLogin(param: LoginRequestDTO(oauthToken: oauthToken), oauth: .kakao)
                                .flatMap { response -> Single<LoginResponseDTO> in
                                    if response.status >= 400 {
                                        return Single.error(AuthErrorType.notFound400)
                                    } else {
                                        return Single.just(response)
                                    }
                                }
                                .subscribe(onSuccess: { element in
                                    MGLogger.debug("appleButtonTap login ✅ \(element))")
                                    TokenManagerImpl().save(token: element.accessToken, with: .authorizationToken)
                                    TokenManagerImpl().save(token: element.refreshToken, with: .refreshToken)
                                }, onFailure: { error in
                                    MGLogger.debug("appleButtonTap login(여기서 절대 에러가 나면 안됩니다...) ❌ \(error)")
                                }).disposed(by: disposeBag)
                        }, onFailure: { error in
                            MGLogger.debug("appleButtonTap recovery ❌ \(error)")
                            AuthStepper.shared.steps.accept(MGStep.authAgreeIsRequired)
                        }).disposed(by: disposeBag)
                }).disposed(by: disposeBag)
        }, onFailure: { error in
            MGLogger.debug("kakaoButtonTap token error ❌ \(error)")
        }).disposed(by: disposeBag)
    }

    public func appleButtonTap() {
        oauthType = .apple
        authRepository.appleButtonTap()
            .subscribe(onSuccess: { [self] token in
                MGLogger.debug("appleButtonTap token ✅ \(token)")
                TokenManagerImpl().save(token: token, with: KeychainType.oauthToken)
                authRepository.oauthLogin(param: LoginRequestDTO(oauthToken: token), oauth: .apple)
                    .flatMap { response -> Single<LoginResponseDTO> in
                        if response.status >= 400 {
                            return Single.error(AuthErrorType.notFound400)
                        } else {
                            return Single.just(response)
                        }
                    }
                    .subscribe(onSuccess: { element in
                        MGLogger.debug("appleButtonTap login ✅ \(String(describing: element))")
                        TokenManagerImpl().save(token: element.accessToken, with: .authorizationToken)
                        TokenManagerImpl().save(token: element.refreshToken, with: .refreshToken)
                        AuthStepper.shared.steps.accept(MGStep.initialization)
                    }, onFailure: { [self] error in
                        MGLogger.debug("appleButtonTap login ❌ \(error)")
                        authRepository.oauthRecovery(param: RecoveryRequestDTO(oauthToken: token), oauth: .apple)
                            .flatMap { response -> Single<RecoveryResponseDTO> in
                                if response.status >= 400 {
                                    return Single.error(AuthErrorType.notFound400)
                                } else {
                                    return Single.just(response)
                                }
                            }
                            .subscribe(onSuccess: { [self] element in
                                MGLogger.debug("appleButtonTap recovery ✅ \(element)")
                                authRepository.oauthLogin(param: LoginRequestDTO(oauthToken: token), oauth: .apple)
                                    .flatMap { response -> Single<LoginResponseDTO> in
                                        if response.status >= 400 {
                                            return Single.error(AuthErrorType.notFound400)
                                        } else {
                                            return Single.just(response)
                                        }
                                    }
                                    .subscribe(onSuccess: { element in
                                        MGLogger.debug("appleButtonTap login ✅ \(String(describing: element))")
                                        TokenManagerImpl().save(token: element.accessToken, with: .authorizationToken)
                                        TokenManagerImpl().save(token: element.refreshToken, with: .refreshToken)
                                    }, onFailure: { error in
                                        MGLogger.debug("appleButtonTap login(여기서 절대 에러가 나면 안됩니다...) ❌ \(error)")
                                    }).disposed(by: disposeBag)
                            }, onFailure: { error in
                                MGLogger.debug("appleButtonTap recovery ❌ \(error)")
                                AuthStepper.shared.steps.accept(MGStep.authAgreeIsRequired)
                            }).disposed(by: disposeBag)
                    }).disposed(by: disposeBag)
            }, onFailure: { error in
                MGLogger.debug("appleButtonTap token error ❌ \(error)")
            }).disposed(by: disposeBag)
    }

    public func nextButtonTap() {
        let accessToken = TokenManagerImpl().get(key: KeychainType.authorizationToken)!
        authRepository.nicknameCheck(param: CheckNicknameRequestDTO(nickname: nicknameText))
            .subscribe(onSuccess: { [self] element in
                MGLogger.debug("nicknameButtonTap nickname ✅ \(element)")
                MGLogger.debug("nicknameButtonTap nickname ✅ \(nicknameText)")

                authRepository.oauthSignup(param: SignupRequestDTO(oauthToken: accessToken, nickname: nicknameText), oauth: .apple)
                .subscribe(onSuccess: { [self] element in
                    MGLogger.debug("nicknameButtonTap Signup ✅ \(element)")
                    authRepository.oauthLogin(param: LoginRequestDTO(oauthToken: accessToken), oauth: .apple)
                        .subscribe(onSuccess: { element in
                            MGLogger.debug("nicknameButtonTap Login ✅ \(element)")
                            TokenManagerImpl().save(token: element.accessToken, with: .authorizationToken)
                            TokenManagerImpl().save(token: element.refreshToken, with: .refreshToken)
                            AuthStepper.shared.steps.accept(MGStep.authCompleteIsRequired)
                        }, onFailure: { error in
                            MGLogger.debug("nicknameButtonTap Login(여기선 절대 에러가 나면 안됩니다...) ❌ \(error)")
                        }).disposed(by: disposeBag)
                }, onFailure: { error in
                    MGLogger.debug("nicknameButtonTap Signup(여기선 절대 에러가 나면 안됩니다...) ❌ \(error)")
                }).disposed(by: disposeBag)
            }, onFailure: { error in
                MGLogger.debug("nicknameButtonTap nickname 중복 ❌ \(error)")
            }).disposed(by: disposeBag)
    }

    public func getIntroData() {
        return authRepository.getIntroData()
            .subscribe(onSuccess: { [weak self] introModel in
                self?.introData.onNext(introModel)
            },
                       onFailure: { error in
                print("AuthUseCase getIntroData error occurred: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
