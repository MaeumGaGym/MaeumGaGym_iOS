import RxSwift

public protocol SignInRepositoryInterface {
    func requestSignIn(token: String) -> Single<Bool>
}
