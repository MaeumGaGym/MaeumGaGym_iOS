import UIKit

import RxMoya

import Alamofire
import Moya

import Core

public protocol BaseAPI: TargetType {
    static var apiType: APIType { get set }
    var csrfToken: String? { get }
    var oauthToken: String? { get }
}

extension BaseAPI {
    public var baseURL: URL {
        var appURL = Config.setConfigTypeAndGetBaseURL(.application)
        var devURL = Config.setConfigTypeAndGetBaseURL(.devTest)
        
        switch Self.apiType {
        case .google:
            appURL += "/google"
        case .kakao:
            appURL += "/kakao"
        case .apple:
            appURL += "/apple"
        }

        guard let url = URL(string: appURL) else {
            fatalError("baseURL could not be configured")
        }

        return url
    }

    public var headers: [String: String]? {
        return HeaderType.createHeaders(csrfToken: self.csrfToken, oauthToken: self.oauthToken)
    }
}

public enum HeaderType {
    static func createHeaders(csrfToken: String?, oauthToken: String?) -> [String: String]? {
        var headers: [String: String] = [:]

        if let csrfToken = csrfToken {
            headers["X-XSRF-TOKEN"] = csrfToken
        }
        if let oauthToken = oauthToken {
            headers["Authorization"] = "Bearer \(oauthToken)"
        }

        return headers.isEmpty ? nil : headers
    }
}
