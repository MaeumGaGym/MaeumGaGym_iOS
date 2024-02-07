import UIKit

import RxSwift
import RxCocoa

public protocol AuthRepositoryInterface {
    func requestSignIn(token: String) -> Single<Bool>
    func kakaoToken(access_token: String) -> Single<String>
    func getCSRFToken() -> Single<String>
}
