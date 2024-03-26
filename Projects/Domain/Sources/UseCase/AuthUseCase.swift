import UIKit

import RxSwift
import RxCocoa

import Core
import Moya

import MGLogger
import TokenManager
import AuthenticationServices

public protocol AuthUseCase {
    func kakaoButtonTap()
    func getIntroData()
    func appleButtonTap()
    func nextButtonTap(nickname: String)
    func setOauthType(oauthType: OauthType)
//    func appleNickNameButtonTap() -> Single<String>
    var appleSignupResult: PublishSubject<String> { get }
    var introData: PublishSubject<IntroModel> { get }
}

public class DefaultAuthUseCase {
    private let authRepository: AuthRepositoryInterface
    private let disposeBag = DisposeBag()
    
    open var oauthType: OauthType!
    
    public let introData = PublishSubject<IntroModel>()
    public let appleSignupResult = PublishSubject<String>()
    public let appleNicknameSignupResult = PublishSubject<String>()

    public init(authRepository: AuthRepositoryInterface) {
        self.authRepository = authRepository
    }
}

extension DefaultAuthUseCase: AuthUseCase {
    public func setOauthType(oauthType: OauthType) {
        self.oauthType = oauthType
    }

    public func nextButtonTap(nickname: String) {
        let accessToken = TokenManagerImpl().get(key: KeychainType.authorizationToken)!
        authRepository.oauthSignup(nickname: nickname,
                                   accessToken: accessToken,
                                   oauth: self.oauthType)
        .subscribe(onNext: { [self] element in
            MGLogger.debug("nicknameButtonTap : \(element)")
            authRepository.oauthLogin(accessToken: accessToken, oauth: self.oauthType)
                .subscribe(onSuccess: { [self] element in
                    MGLogger.debug("nicknameButtonTap Login : \(element)")
                    AuthStepper.shared.steps.accept(MGStep.authCompleteIsRequired)
                }, onFailure: { error in
                    MGLogger.debug("nicknameButtonTap Login Error : \(error)")
                }).disposed(by: disposeBag)
        }, onError: { error in
            MGLogger.debug("nicnameButtonTap Error : \(error)")
        }).disposed(by: disposeBag)
    }
    
    public func appleButtonTap() {
        authRepository.appleButtonTap()
            .subscribe(onSuccess: { [self] token in
                MGLogger.debug("appleButtonTap token ✅ \(token)")
                TokenManagerImpl().save(token: token, with: KeychainType.authorizationToken)
                authRepository.oauthLogin(accessToken: token, oauth: .apple)
                    .subscribe(onSuccess: { element in
                        MGLogger.debug("appleButtonTap login ✅ \(String(describing: element.response))")
                        AuthStepper.shared.steps.accept(MGStep.authCompleteIsRequired)
                    }, onFailure: { [self] error in
                        MGLogger.debug("appleButtonTap login ❌ \(error)")
                        authRepository.oauthRecovery(accessToken: token, oauth: .apple)
                            .subscribe(onSuccess: { [self] element in
                                MGLogger.debug("appleButtonTap recovery ✅ \(element)")
                                authRepository.oauthLogin(accessToken: token, oauth: .apple)
                                    .subscribe(onSuccess: { element in
                                        MGLogger.debug("appleButtonTap login ✅ \(String(describing: element.response))")
                                    }, onFailure: { error in
                                        MGLogger.debug("appleButtonTap login(여기서 절대 에러가 나면 안됩니다...) ❌ \(error)")
                                    }).disposed(by: disposeBag)
                            }, onFailure: { error in
                                MGLogger.debug("appleButtonTap recovery ❌ \(error)")
                                AuthStepper.shared.steps.accept(MGStep.authAgreeIsRequired)
                            })
                    }).disposed(by: disposeBag)
            }, onFailure: { error in
                MGLogger.debug("appleButtonTap token error ❌ \(error)")
            }).disposed(by: disposeBag)
    }

//    public func appleButtonTap() {
//        authRepository.appleButtonTap()
//            .subscribe(onSuccess: { [self] token in
//                    TokenManagerImpl().save(token: token, with: KeychainType.authorizationToken)
//                    authRepository.oauthLogin(accessToken: token, oauth: .apple)
//                        .subscribe(onSuccess: { element in
////                            TokenManagerImpl().save(token: (element.response?.allHeaderFields["Authorization"] as? String)!, with: .authorizationToken)
////                            TokenManagerImpl().save(token: (element.response?.allHeaderFields["RF-TOKEN"] as? String)!, with: .refreshToken)
//                            MGLogger.debug("loginㄴㅇㄹㄴㅇㄹ : \(element.response?.description)")
////                            MGLogger.debug("login : \(TokenManagerImpl().get(key: .authorizationToken))")
////                            MGLogger.debug("login : \(TokenManagerImpl().get(key: .refreshToken))")
//
//                            AuthStepper.shared.steps.accept(MGStep.authCompleteIsRequired)
//                        }, onFailure: { [self] error in
//                            MGLogger.debug("appleLogin : \(error)")
//                            authRepository.oauthRecovery(accessToken: token, oauth: .apple)
//                                .subscribe(onNext: { element in
//                                    MGLogger.debug("success : \(element)")
//                                }, onError: { [self] recoveryError in
//                                    MGLogger.debug("error !!!! \(recoveryError)")
//                                    authRepository.oauthSignup(nickname: "이은호", accessToken: token, oauth: .apple)
//                                        .subscribe(onNext: { element in
//                                            MGLogger.debug("signup : \(element)")
//                                            self.authRepository.oauthLogin(accessToken: token, oauth: .apple).subscribe(onSuccess: { response in
//                                                MGLogger.debug("login : \(String(describing: response.response?.headers))")
//                                            }, onFailure: { error in
//                                                MGLogger.debug("login error : \(error)")
//                                            }
//                                            ).disposed(by: self.disposeBag)
//                                        }, onError: { error in
//                                            MGLogger.debug("signup error : \(error)")
//                                        }
//                                        ).disposed(by: disposeBag)
////                                    AuthStepper.shared.steps.accept(MGStep.authAgreeIsRequired)
//                                }).disposed(by: disposeBag)
//                        }
//                        ).disposed(by: disposeBag)
//                },
//                onFailure: { [weak self] error in
//                    self?.appleSignupResult.onError(error)
//                }
//            )
//            .disposed(by: disposeBag)
//    }
    
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

    public func kakaoButtonTap() {
        return authRepository.kakaoToken()
            .subscribe(onSuccess: { _ in
                print("토큰 저장 성공")
            }, onFailure: { error in
                print("AuthUseCase getIntroData error occurred: \(error)")
            })
            .disposed(by: self.disposeBag)
    }

//    public func appleNickNameButtonTap(nickname: String) -> Single<String> {
//        return authRepository.appleSingup(nickname: nickname, accessToken: TokenManagerImpl().get(key: .authorizationToken)).mapString
//    }
}
