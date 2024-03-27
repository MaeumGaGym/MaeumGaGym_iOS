import UIKit

import RxMoya

import Alamofire
import Moya

import Core
import Kingfisher

public protocol BaseAPI: TargetType {
    static var apiType: APIType { get set }
}

extension BaseAPI {
    public var baseURL: URL {
        var appURL = Config.setConfigTypeAndGetBaseURL(.devTest)
//        var devURL = Config.setConfigTypeAndGetBaseURL(.devTest)
        
        switch Self.apiType {
        case .CSRFToken:
            appURL += "/public"
        case .kakao:
            appURL += "/kakao"
        case .google:
            appURL += "/google"
        case .apple:
            appURL += "/apple"
        case .auth:
            appURL += "/auth"
        }

        guard let url = URL(string: appURL) else {
            fatalError("baseURL could not be configured")
        }

        return url
    }
}

public enum HeaderType {
//    static func createHeaders(api: BaseAPI) -> [String: String]? {
//        var headers: [String: String] = [:]
//
//        if let csrfToken = api.csrfToken {
//            headers["X-XSRF-TOKEN"] = csrfToken
//        }
//        if let oauthToken = api.oauthToken {
//            headers["Authorization"] = "Bearer \(oauthToken)"
//        }
//
//        return headers.isEmpty ? nil : headers
//    }
}
