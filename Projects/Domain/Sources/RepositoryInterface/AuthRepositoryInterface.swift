import UIKit

import RxSwift
import RxCocoa

public protocol AuthRepositoryInterface {
    func kakaoToken() -> Single<Bool>
    func getCSRFToken() -> Single<String>
    func getIntroData() -> Single<IntroModel>
    func appleSignup() -> Single<String>
    func appleSingup(nickname: String, accessToken: String) -> Single<String>
}
