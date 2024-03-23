import UIKit

import RxSwift
import RxCocoa

public enum OauthType {
    case google
    case kakao
    case apple
}

public struct LoginResponseDTO: Decodable {
    public let status: Int
    public let accessToken: String
    public let refreshToken: String
}

public struct SignupResponseDTO: Decodable {
    public let status: Int
}

public struct RecoveryResponseDTO: Decodable {
    public let status: Int
}

public protocol AuthRepositoryInterface {
    func googleToken() -> Single<Bool>
    func kakaoToken() -> Single<Bool>
    func appleToken() -> Single<Bool>
    func appleButtonTap() -> Single<String>
    func oauthSignup(nickname: String, accessToken: String, oauth: OauthType) -> Observable<SignupResponseDTO>
    func oauthLogin(accessToken: String, oauth: OauthType) -> Observable<LoginResponseDTO>
    func oauthRecovery(accessToken: String, oauth: OauthType) -> Observable<RecoveryResponseDTO>
    func getIntroData() -> Single<IntroModel>
}
