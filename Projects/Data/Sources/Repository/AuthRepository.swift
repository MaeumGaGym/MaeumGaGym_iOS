import UIKit

import RxSwift
import RxCocoa

import Moya
import RxMoya

import Domain
import MGNetworks

public class AuthRepository: AuthRepositoryInterface {
    private let networkService: AuthService

    public init(networkService: AuthService) {
        self.networkService = networkService
    }

    public func kakaoToken() -> Single<Bool> {
        networkService.kakaoTokenState()
    }
    
    public func getCSRFToken() -> Single<String> {
        return networkService.getCSRFToken()
    }
    
    public func getIntroData() -> Single<IntroModel>  {
        return networkService.requestIntroData()
    }

    public func appleSignup() -> RxSwift.Single<String> {
        return networkService.appleSignup()
    }

    public func appleSingup(nickname: String, accessToken: String) -> Single<String> {
        return networkService.appleSignup(nickname: nickname, accessToken: accessToken)
    }
}
