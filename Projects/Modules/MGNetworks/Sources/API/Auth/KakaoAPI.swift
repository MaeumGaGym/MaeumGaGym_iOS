import Foundation

import Moya
import Core
import Alamofire

public enum KakaoAPI {
    case kakaoSignup(nickname: String, accessToken: String)
    case kakaoLogin(accessToken: String)
    case kakaoRecovery(accessToken: String)
}

extension KakaoAPI: BaseAPI {

    public static var apiType: APIType = .kakao

    public var path: String {
        switch self {
        case .kakaoSignup:
            return "/signup"
        case .kakaoLogin:
            return "/login"
        case .kakaoRecovery:
            return "/recovery"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .kakaoSignup:
            return .post
        case .kakaoLogin:
            return .get
        case .kakaoRecovery:
            return .put
        }
    }

    public var task: Moya.Task {
        switch self {
        case let .kakaoSignup(nickname, accessToken):
            let bodyParameters: [String: Any] = [
                "nickname": nickname
            ]
            let urlParameters: [String: Any] = [
                "access_token": accessToken
            ]
            return .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: urlParameters)
        case let .kakaoLogin(accessToken):
            let parameters: [String: Any] = [
                "access_token": accessToken
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .kakaoRecovery(accessToken):
            let parameters: [String: Any] = [
                "access_token": accessToken
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String : String]? {
        return nil
    }
}
