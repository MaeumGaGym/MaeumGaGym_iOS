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
//    func appleNickNameButtonTap() -> Single<String>
    var appleSignupResult: PublishSubject<String> { get }
    var introData: PublishSubject<IntroModel> { get }
}

public class DefaultAuthUseCase {
    private let authRepository: AuthRepositoryInterface
    private let disposeBag = DisposeBag()
    
    public let introData = PublishSubject<IntroModel>()
    public let appleSignupResult = PublishSubject<String>()
    public let appleNicknameSignupResult = PublishSubject<String>()


    public init(authRepository: AuthRepositoryInterface) {
        self.authRepository = authRepository
    }
}

extension DefaultAuthUseCase: AuthUseCase {

    public func appleButtonTap() {
        authRepository.appleButtonTap()
            .subscribe(
                onSuccess: { [self] token in
                    appleSignupResult.onNext(token)
                    TokenManagerImpl().save(token: token, with: KeychainType.authorizationToken)
                    authRepository.oauthLogin(accessToken: token, oauth: .apple)
                        .subscribe(onNext: { element in
                            MGLogger.debug("\(element)")
                            AuthStepper.shared.steps.accept(MGStep.authCompleteIsRequired)
                        }, onError: { error in
                            MGLogger.debug("appleLogin : \(error)")
                            self.authRepository.oauthRecovery(accessToken: token, oauth: .apple)
                                .subscribe(onNext: { element in
                                    MGLogger.debug("\(element)")
                                }, onError: { error in
                                    MGLogger.debug("\(error)")
                                    AuthStepper.shared.steps.accept(MGStep.authAgreeIsRequired)
                                }).disposed(by: self.disposeBag)
                        }
                        ).disposed(by: disposeBag)
                },
                onFailure: { [weak self] error in
                    self?.appleSignupResult.onError(error)
                }
            )
            .disposed(by: disposeBag)
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
