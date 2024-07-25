import UIKit

import RxSwift
import RxCocoa

import RxMoya
import Moya

import DSKit
import Domain
import TokenManager

public protocol PostureService {
    func requestRecommandData(accessToken: String) ->
    Single<Response>
    func requestPartData(category: String, accessToken: String) ->
    Single<Response>
    func requestDetailData(accessToken: String, id: Int) -> Single<Response>
    func getAllPoseData(accessToken: String, lastUpdated: String) -> Single<Response>
}

public class DefaultPostureService: NSObject {
    let postureProvider = MoyaProvider<PostureAPI>()
}

extension DefaultPostureService: PostureService {
    public func requestRecommandData(accessToken: String) ->
    Single<Response> {
        postureProvider.rx.request(.postureRecommand(accessToken: accessToken)).filterSuccessfulStatusCodes()
    }
    
    public func requestPartData(category: String, accessToken: String) ->
    Single<Response> {
        postureProvider.rx.request(.postureSearch(accessToken: accessToken, tag: category)).filterSuccessfulStatusCodes()
    }
    
    public func requestDetailData(accessToken: String, id: Int) -> Single<Response> {
        postureProvider.rx.request(.postureShow(accessToken: accessToken, id: id)).filterSuccessfulStatusCodes()
    }
    
    public func getAllPoseData(accessToken: String, lastUpdated: String) -> Single<Response> {
        return postureProvider.rx.request(.postureAllShow(accessToken: accessToken, last_updated: lastUpdated)).filterSuccessfulStatusCodes()
    }
}
