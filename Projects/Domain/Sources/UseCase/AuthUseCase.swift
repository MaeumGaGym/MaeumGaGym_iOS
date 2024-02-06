import UIKit

import RxSwift
import RxCocoa

import Core
import KakaoSDKUser
import Moya

//import TokenManager

public enum AuthHandleableType {
    case loginSuccess
    case loginFailure
}

public protocol AuthUseCase {
    func requestSignIn(token: String)
    func kakaoButtonTap()
    func getCSRFToken() -> Single<String>
    var signInResult: PublishSubject<Result<AuthHandleableType, Error>> { get }
}

public class DefaultAuthUseCase {
    private let authRepository: AuthRepositoryInterface
    private let disposeBag = DisposeBag()
    
//    private let keychainAuthorization = KeychainType.authorizationToken


    public init(authRepository: AuthRepositoryInterface) {
        self.authRepository = authRepository
    }
}

extension DefaultAuthUseCase: AuthUseCase {
    

    public func getCSRFToken() -> Single<String> {
        return authRepository.getCSRFToken()
    }
    
    public func kakaoButtonTap() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    guard let self = self, let accessToken = oauthToken?.accessToken else { return }
                        
                    self.authRepository.kakaoToken(access_token: accessToken)
                        .subscribe(onSuccess: { [weak self] _ in
//                            guard let self = self else { return }
//                            if TokenManagerImpl().save(token: accessToken, with: self.keychainAuthorization) {
//                                print("토큰 저장 성공")
//                            } else {
//                                print("토큰 저장 실패")
//                            }
//                            self.signInResult.onNext(.success(.loginSuccess))
                        }, onFailure: { [weak self] error in
                            self?.signInResult.onNext(.failure(error))
                        })
                        .disposed(by: self.disposeBag)
                }
            }
        }
    }
    
    public func requestSignIn(token: String) {
        authRepository.requestSignIn(token: token)
            .subscribe(onSuccess: { [weak self] _ in
                self?.signInResult.onNext(.success(.loginSuccess))
                print("성공")
            }, onFailure: { [weak self] error in
                self?.signInResult.onNext(.failure(error))
            })
            .disposed(by: disposeBag)
    }

    public var signInResult: PublishSubject<Result<AuthHandleableType, Error>> {
        return PublishSubject<Result<AuthHandleableType, Error>>()
    }
}
