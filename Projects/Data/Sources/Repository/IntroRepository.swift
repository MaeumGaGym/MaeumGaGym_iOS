import UIKit

import RxSwift
import RxCocoa

import Moya
import RxMoya

import Domain
import MGNetworks

public class IntroRepository: IntroRepositoryInterface {
    private let networkService: IntroService

    public init(networkService: IntroService) {
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
    
    
}
