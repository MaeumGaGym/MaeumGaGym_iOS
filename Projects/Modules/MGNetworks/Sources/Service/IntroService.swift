import UIKit

import RxSwift
import RxCocoa

import RxMoya
import Moya

import Domain

public class IntroService {
    
    let provider = MoyaProvider<CsrfAPI>()
    
    public func requestToken() -> Single<Bool> {
        return Single.just(true)
    }
    
    public func kakaoTokenState(access_token: String) -> Single<String> {
        return Single.deferred {
            return Single.create { single in
                let result = access_token
                
                single(.success(result))
                
                return Disposables.create()
            }
        }
    }
    
    public func getCSRFToken() -> Single<String> {
        return provider.rx.request(.getCSRFToken)
            .flatMap { response -> Single<String> in
                if let setCookieHeader = response.response?.allHeaderFields["Set-Cookie"] as? String {
                    let cookies = setCookieHeader.components(separatedBy: ", ")
                    for cookie in cookies {
                        if cookie.hasPrefix("XSRF-TOKEN") {
                            let token = cookie.components(separatedBy: "=")[1].components(separatedBy: ";")[0]
                            return Single.just(token)
                        }
                    }
                }
                return Single.error(AuthError.tokenNotFound)
            }
    }
    
    public init() {
        
    }
}
