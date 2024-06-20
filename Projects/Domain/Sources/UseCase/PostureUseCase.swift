import UIKit

import RxSwift
import RxCocoa

import Core
import Moya

import MGLogger
import TokenManager

public protocol PostureUseCase {
    var recommandData: PublishSubject<PoseRecommandModel> { get }
    var partData: PublishSubject<PosturePartModel> { get }
    var detailData: PublishSubject<PostureDetailModel> { get }
    var searchData: PublishSubject<PostureSearchModel> { get }
    var poseAllData: PublishSubject<PostureAllModel> { get }

    func getRecommandData()
    func getPartData(type: PosturePartType)
    func getDetailData(id: Int)
    func getSearchData()
    func getAllPoseData()
}

public class DefaultPostureUseCase {
    private let repository: PostureRepositoryInterface
    private let disposeBag = DisposeBag()


    private let accessToken = TokenManagerImpl().get(key: .accessToken)
    public let recommandData = PublishSubject<PoseRecommandModel>()
    public let partData = PublishSubject<PosturePartModel>()
    public let detailData = PublishSubject<PostureDetailModel>()
    public let searchData = PublishSubject<PostureSearchModel>()
    public let poseAllData = PublishSubject<PostureAllModel>()

    public init(repository: PostureRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultPostureUseCase: PostureUseCase {

    public func getRecommandData() {
        let accessToken = TokenManagerImpl().get(key: .accessToken)
        repository.getRecommandData(accessToken: accessToken!)
            .subscribe(onSuccess: { [weak self] recommandData in
                self?.recommandData.onNext(recommandData)
            },
            onFailure: { error in
                print("PostureUseCase getRecommandData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getPartData(type: PosturePartType) {
        repository.getPartData(type: type)
            .subscribe(onSuccess: { [weak self] partData in
                self?.partData.onNext(partData)
            },
            onFailure: { error in
                print("PostureUseCase getPartData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getDetailData(id: Int) {
        repository.getDetailData(accessToken: accessToken ?? "", id: id)
            .subscribe(onSuccess: { [weak self] detailData in
                self?.detailData.onNext(detailData)
            },
            onFailure: { error in
                print("PostureUseCase getDetailData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }

    public func getSearchData() {
        repository.getSearchData()
            .subscribe(onSuccess: { [weak self] searchData in
                self?.searchData.onNext(searchData)
            },
            onFailure: { error in
                print("PostureUseCase getSearchData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }
    
    public func getAllPoseData() {
        let accessToken = TokenManagerImpl().get(key: .accessToken)
        repository.getAllPoseData(accessToken: accessToken!, lastUpdated: "2000-01-01T03:12")
            .subscribe(onSuccess: { [weak self] poseData in
                MGLogger.debug("좋았쒀 영촤~ : \(poseData.responses)")
                self?.poseAllData.onNext(poseData)
        }, onFailure: { error in
            print("poseData error : \(error)")
        }).disposed(by: disposeBag)
    }
}
