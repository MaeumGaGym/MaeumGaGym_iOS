import UIKit

import RxSwift
import RxCocoa

public protocol IntroRepositoryInterface {
    func kakaoToken(access_token: String) -> Single<String>
    func getCSRFToken() -> Single<String>
    func getIntroData() -> Single<IntroModel>
    func appleLogin() -> Single<String>
}
