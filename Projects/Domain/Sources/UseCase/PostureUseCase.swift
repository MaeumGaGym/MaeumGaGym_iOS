import UIKit

import RxSwift
import RxCocoa

import Core
import Moya

import MGLogger
import TokenManager

public protocol PostureUseCase {
    var recommandData: PublishSubject<PoseRecommandModel> { get }
    var categoryChestData: PublishSubject<PosePartModel> { get }
    var categoryBackData: PublishSubject<PosePartModel> { get }
    var categoryShoulderData: PublishSubject<PosePartModel> { get }
    var categoryArmData: PublishSubject<PosePartModel> { get }
    var categoryLegData: PublishSubject<PosePartModel> { get }


    var detailData: PublishSubject<PostureDetailModel> { get }
    var searchData: PublishSubject<PosePartModel> { get }
    var poseAllData: PublishSubject<PostureAllModel> { get }

    func getRecommandData()
    func getChestData()
    func getBackData()
    func getShoulderData()
    func getArmData()
    func getLegData()

    func getDetailData(id: Int)
    func getSearchData(category: String)
    func getAllPoseData()
}

public class DefaultPostureUseCase {
    private let repository: PostureRepositoryInterface
    private let disposeBag = DisposeBag()

    private let accessToken = TokenManagerImpl().get(key: .accessToken)
    public let recommandData = PublishSubject<PoseRecommandModel>()
    public let categoryChestData = PublishSubject<PosePartModel>()
    public let categoryBackData = PublishSubject<PosePartModel>()
    public let categoryShoulderData = PublishSubject<PosePartModel>()
    public let categoryArmData = PublishSubject<PosePartModel>()
    public let categoryLegData = PublishSubject<PosePartModel>()


    public let detailData = PublishSubject<PostureDetailModel>()
    public let searchData = PublishSubject<PosePartModel>()
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

    public func getChestData() {
        repository.getPartData(accessToken: accessToken ?? "", category: "가슴")
            .subscribe(onSuccess: { [weak self] partData in
                self?.categoryChestData.onNext(partData)
            },
            onFailure: { error in
                print("PostureUseCase getChestData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }
    
    public func getBackData() {
        repository.getPartData(accessToken: accessToken ?? "", category: "등")
            .subscribe(onSuccess: { [weak self] partData in
                self?.categoryBackData.onNext(partData)
            },
            onFailure: { error in
                print("PostureUseCase getBacktData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }
    
    public func getShoulderData() {
        repository.getPartData(accessToken: accessToken ?? "", category: "어깨")
            .subscribe(onSuccess: { [weak self] partData in
                self?.categoryShoulderData.onNext(partData)
            },
            onFailure: { error in
                print("PostureUseCase getShoulderData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }
    
    public func getArmData() {
        repository.getPartData(accessToken: accessToken ?? "", category: "팔")
            .subscribe(onSuccess: { [weak self] partData in
                self?.categoryArmData.onNext(partData)
            },
            onFailure: { error in
                print("PostureUseCase getArmData error occurred: \(error)")
            }).disposed(by: disposeBag)
    }
    
    public func getLegData() {
        repository.getPartData(accessToken: accessToken ?? "", category: "하체")
            .subscribe(onSuccess: { [weak self] partData in
                self?.categoryLegData.onNext(partData)
            },
            onFailure: { error in
                print("PostureUseCase getLegData error occurred: \(error)")
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

    public func getSearchData(category: String) {
        repository.getPartData(accessToken: accessToken ?? "", category: category)
            .subscribe(onSuccess: { [weak self] searchData in
                self?.searchData.onNext(searchData)
            }, onFailure: { _ in 
                self.searchData.onNext(PosePartModel(responses: []))
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
