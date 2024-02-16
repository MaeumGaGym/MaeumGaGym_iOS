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
    var appleLoginResult: PublishSubject<String> { get }
    var introData: PublishSubject<IntroModel> { get }
}

public class DefaultAuthUseCase {
    private let introRepository: IntroRepositoryInterface
    private let disposeBag = DisposeBag()
    
    public let introData = PublishSubject<IntroModel>()
    public let appleLoginResult = PublishSubject<String>()

    public init(introRepository: IntroRepositoryInterface) {
        self.introRepository = introRepository
    }
}

extension DefaultAuthUseCase: AuthUseCase {
    
    public func appleButtonTap() -> Single<String> {
        introRepository.appleLogin()
            .subscribe(
                onSuccess: { [weak self] token in
                    self?.appleLoginResult.onNext(token)
                },
                onFailure: { [weak self] error in
                    self?.appleLoginResult.onError(error)
                }
            )
            .disposed(by: disposeBag)
    
        return appleLoginResult.take(1).asSingle()
    }
    
    public func getIntroData() {
        return introRepository.getIntroData()
            .subscribe(onSuccess: { [weak self] introModel in
                self?.introData.onNext(introModel)
            },
            onFailure: { error in
                print("AuthUseCase getIntroData error occurred: \(error)")
            })
            .disposed(by: disposeBag)
    }

    public func getCSRFToken() -> Single<String> {
        return introRepository.getCSRFToken()
    }
    
    public func kakaoButtonTap() {
        return introRepository.kakaoToken()
            .subscribe(onSuccess: { _ in
                print("토큰 저장 성공")
            }, onFailure: { error in
                print("AuthUseCase getIntroData error occurred: \(error)")
            })
            .disposed(by: self.disposeBag)
        
    }
}
