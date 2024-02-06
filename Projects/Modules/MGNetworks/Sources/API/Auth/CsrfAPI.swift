import Foundation

import Alamofire
import Moya
import Core

public enum CsrfAPI {
    case getCSRFToken
}

extension CsrfAPI: BaseAPI {
    
    public static var apiType: APIType = .CSRFToken
    
    var apiType: APIType {
         switch self {
         case .getCSRFToken:
             return .CSRFToken
         }
     }
    
    public var path: String {
        switch self {
        case .getCSRFToken:
            return "/csrf"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }

    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
