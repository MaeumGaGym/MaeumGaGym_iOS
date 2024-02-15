import UIKit

import RxSwift
import RxCocoa

import Core
import KakaoSDKUser
import Moya

import TokenManager

public protocol AuthUseCase {
    func kakaoButtonTap()
    func getCSRFToken() -> Single<String>
    func getIntroData()
    var introData: PublishSubject<IntroModel> { get }
}

public class DefaultAuthUseCase {
    private let introRepository: IntroRepositoryInterface
    private let disposeBag = DisposeBag()
    
    public let introData = PublishSubject<IntroModel>()
    
    private let keychainAuthorization = KeychainType.authorizationToken

    public init(introRepository: IntroRepositoryInterface) {
        self.introRepository = introRepository
    }
}

extension DefaultAuthUseCase: AuthUseCase {
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
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    guard let self = self, let accessToken = oauthToken?.accessToken else { return }
                        
                    self.introRepository.kakaoToken(access_token: accessToken)
                        .subscribe(onSuccess: { [weak self] _ in
                            guard let self = self else { return }
                            if TokenManagerImpl().save(token: accessToken, with: self.keychainAuthorization) {
                                print("토큰 저장 성공")
                            } else {
                                print("토큰 저장 실패")
                            }
                        }, onFailure: { [weak self] error in
                            fatalError("\(error)")
                        })
                        .disposed(by: self.disposeBag)
                }
            }
        }
    }
}
