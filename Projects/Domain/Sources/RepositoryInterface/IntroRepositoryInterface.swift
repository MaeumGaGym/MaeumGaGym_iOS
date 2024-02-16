import UIKit

import RxSwift
import RxCocoa

public protocol IntroRepositoryInterface {
    func kakaoToken() -> Single<Bool>
    func getCSRFToken() -> Single<String>
    func getIntroData() -> Single<IntroModel>
}
