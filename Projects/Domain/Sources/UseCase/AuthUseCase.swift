import UIKit

import RxSwift
import RxCocoa

import Core
import Moya

import TokenManager

public protocol AuthUseCase {
    func kakaoButtonTap()
    func getCSRFToken() -> Single<String>
    func getIntroData()
    func appleButtonTap() -> Single<String>
    var appleSignupResult: PublishSubject<String> { get }
    var introData: PublishSubject<IntroModel> { get }
}

public class DefaultAuthUseCase {
    private let authRepository: AuthRepositoryInterface
    private let disposeBag = DisposeBag()
    
    public let introData = PublishSubject<IntroModel>()
    public let appleSignupResult = PublishSubject<String>()

    public init(authRepository: AuthRepositoryInterface) {
        self.authRepository = authRepository
    }
}

extension DefaultAuthUseCase: AuthUseCase {
    
    public func appleButtonTap() -> Single<String> {
        authRepository.appleSignup()
            .subscribe(
                onSuccess: { [weak self] token in
                    self?.appleSignupResult.onNext(token)
                },
                onFailure: { [weak self] error in
                    self?.appleSignupResult.onError(error)
                }
            )
            .disposed(by: disposeBag)
    
        return appleSignupResult.take(1).asSingle()
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

    public func getCSRFToken() -> Single<String> {
        return authRepository.getCSRFToken()
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
}
