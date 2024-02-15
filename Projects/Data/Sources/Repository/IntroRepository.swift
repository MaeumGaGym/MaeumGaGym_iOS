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

    public func kakaoToken(access_token: String) -> Single<String> {
        networkService.kakaoTokenState(access_token: access_token)
    }
    
    public func getCSRFToken() -> Single<String> {
        return networkService.getCSRFToken()
    }
    
    public func getIntroData() -> Single<IntroModel>  {
        return networkService.requestIntroData()
    }
}
