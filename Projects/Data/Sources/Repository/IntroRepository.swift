import UIKit

import RxSwift
import RxCocoa

import Moya
import RxMoya

import Domain
import MGNetworks

public class IntroRepository: IntroRepositoryInterface {
    
    private let networkService: AuthService

    public init(networkService: AuthService) {
        self.networkService = networkService
    }

    public func requestSignIn(token: String) -> Single<Bool> {
        return networkService.requestToken()
    }

    public func kakaoToken(access_token: String) -> Single<String> {
        networkService.kakaoTokenState(access_token: access_token)
    }
    
    public func getCSRFToken() -> Single<String> {
        return networkService.getCSRFToken()
    }
}
