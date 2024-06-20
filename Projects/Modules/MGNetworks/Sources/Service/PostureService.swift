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
    func requestPartData(type: PosturePartType) -> Single<PosturePartModel>
    func requestDetailData(accessToken: String, id: Int) -> Single<Response>
    func requestSearchData() -> Single<PostureSearchModel>
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

    public func requestPartData(type: PosturePartType) ->
    Single<PosturePartModel> {
        switch type {
        case .chest:
            return requestChestData()
        case .back:
            return requestBackData()
        }
    }

    public func requestDetailData(accessToken: String, id: Int) -> Single<Response> {
        postureProvider.rx.request(.postureShow(accessToken: accessToken, id: id)).filterSuccessfulStatusCodes()
    }
    
    public func getAllPoseData(accessToken: String, lastUpdated: String) -> Single<Response> {
        return postureProvider.rx.request(.postureAllShow(accessToken: accessToken, last_updated: lastUpdated)).filterSuccessfulStatusCodes()
    }

    public func requestSearchData() -> Single<PostureSearchModel> {
        return.just(
            PostureSearchModel(
                searchResultData: [
                    PostureSearchContentModel(exerciseImage: DSKitAsset.Assets.airSqt.image,
                                              exerciseName: "에어 스쿼트", exercisePart: "하체"),
                    PostureSearchContentModel(exerciseImage: DSKitAsset.Assets.archPushUp.image,
                                              exerciseName: "아치 푸시업", exercisePart: "하체"),
                    PostureSearchContentModel(exerciseImage:  DSKitAsset.Assets.babelLow.image,
                                              exerciseName: "바벨 로우", exercisePart: "팔"),
                    PostureSearchContentModel(exerciseImage: DSKitAsset.Assets.babelBackSqt.image,
                                              exerciseName: "바벨 백 스쿼트", exercisePart: "하체"),
                    PostureSearchContentModel(exerciseImage: DSKitAsset.Assets.babelBgrSplitSqt.image,
                                              exerciseName: "바벨 불가리안 스플릿 스쿼트", exercisePart: "하체"),
                    PostureSearchContentModel(exerciseImage: DSKitAsset.Assets.bodySplitSqt.image,
                                              exerciseName: "바디 스플릿 스쿼트", exercisePart: "하체"),
                    PostureSearchContentModel(exerciseImage: DSKitAsset.Assets.clapPushUp.image,
                                              exerciseName: "클랩 푸시업", exercisePart: "가슴"),
                    PostureSearchContentModel(exerciseImage: DSKitAsset.Assets.invertedLow.image,
                                              exerciseName: "인버티드 로우", exercisePart: "하체"),
                    PostureSearchContentModel(exerciseImage: DSKitAsset.Assets.pullUp.image,
                                              exerciseName: "풀업", exercisePart: "등"),
                    PostureSearchContentModel(exerciseImage: DSKitAsset.Assets.weightDeeps.image,
                                              exerciseName: "중량 딥스", exercisePart: "가슴"),
                ]
            )
        )
    }
}

private extension DefaultPostureService {
    func requestChestData() ->
    Single<PosturePartModel> {
        return Single.just(
            PosturePartModel(
                exerciseType: [
                    PosturePartExerciseTypeModel(
                        exerciseName: "맨몸"),
                    PosturePartExerciseTypeModel(
                        exerciseName: "기구")
                ],
                allExerciseData: [
                    PosturePartExerciseModel(image: DSKitAsset.Assets.benchPress.image, name: "벤치프레스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.deeps.image, name: "딥스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.inclineBenchPress.image, name: "인클라인 벤치프레스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.pushUp.image, name: "푸시업"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.dumbelBenchPress.image, name: "덤벨 벤치프레스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.hinduPushUp.image, name: "힌두 푸시업"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.weightDeeps.image, name: "중량 딥스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.archPushUp.image, name: "아치 푸시업"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.inclineDumbelBenchPress.image, name: "인클라인 덤벨 벤치프레스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.closeGripPushUp.image, name: "클로즈그립 푸시업"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.dumbelSqzPress.image, name: "덤벨 스퀴즈 프레스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.clapPushUp.image, name: "클랩 푸시업"),
                ],
                bodyExerciseData: [
                    PosturePartExerciseModel(image: DSKitAsset.Assets.deeps.image, name: "딥스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.pushUp.image, name: "푸시업"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.hinduPushUp.image, name: "힌두 푸시업"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.archPushUp.image, name: "아치 푸시업"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.closeGripPushUp.image, name: "클로즈그립 푸시업"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.clapPushUp.image, name: "클랩 푸시업"),
                ],
                machineExerciseData: [
                    PosturePartExerciseModel(image: DSKitAsset.Assets.benchPress.image, name: "벤치프레스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.inclineBenchPress.image, name: "인클라인 벤치프레스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.dumbelBenchPress.image, name: "덤벨 벤치프레스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.weightDeeps.image, name: "중량 딥스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.inclineDumbelBenchPress.image, name: "인클라인 덤벨 벤치프레스"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.dumbelSqzPress.image, name: "덤벨 스퀴즈 프레스"),
                ]
            )
        )
    }

    func requestBackData() ->
    Single<PosturePartModel> {
        return Single.just(
            PosturePartModel(
                exerciseType: [
                    PosturePartExerciseTypeModel(
                        exerciseName: "맨몸"),
                    PosturePartExerciseTypeModel(
                        exerciseName: "기구")
                ],
                allExerciseData: [
                    PosturePartExerciseModel(image: DSKitAsset.Assets.goodMorningExercise.image, name: "굿모닝 엑서사이즈"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.pullUp.image, name: "풀업"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.babelLow.image, name: "바벨 로우"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.invertedLow.image, name: "인버티드 로우"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.inclineDumbelLow.image, name: "인클라인 덤벨 로우"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.hyperExtension.image, name: "하이퍼 익스텐션"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.dumbelLow.image, name: "덤벨 로우"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.backExtension.image, name: "백 익스텐션"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.ratPullDown.image, name: "랫풀다운")
                ],
                bodyExerciseData: [
                    PosturePartExerciseModel(image: DSKitAsset.Assets.pullUp.image, name: "풀업"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.invertedLow.image, name: "인버티드 로우"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.hyperExtension.image, name: "하이퍼 익스텐션"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.backExtension.image, name: "백 익스텐션")
                ],
                machineExerciseData: [
                    PosturePartExerciseModel(image: DSKitAsset.Assets.goodMorningExercise.image, name: "굿모닝 엑서사이즈"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.babelLow.image, name: "바벨 로우"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.inclineDumbelLow.image, name: "인클라인 덤벨 로우"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.dumbelLow.image, name: "덤벨 로우"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.ratPullDown.image, name: "랫풀다운"),
                ]
            )
        )
    }
}

//private extension PostureService {
//    func requestPushUpData() -> Single<PostureDetailModel>{
//        return Single.just(
//            PostureDetailModel_temporary(
//            needMachine: false,
//            category: ["복근", "등"],
//            simpleName: "러시안 트위스트",
//            exactName: "러시안 트위스트",
//            thumbnail: "",
//            video: "",
//            simplePart: ["복근", "등"],
//            exactPart: ["복근", "내복사근"],
//            startPose: [
//                "바닥에 앉아 무릎을 구부리고",
//                " 발뒤꿈치를 바닥에 대거나 약간 들고",
//                " 상체를 약간 뒤로 기울여 균형을 잡으세요."
//            ],
//            exerciseWay: [
//                "양손을 가슴 앞에서 모으거나 손가락을 서로 걸어 잡습니다.",
//                "상체를 좌우로 돌려가며 손을 바닥 가까이로 움직입니다.",
//                "한쪽으로 돌린 후 반대쪽으로 같은 방법으로 돌립니다."
//            ],
//            breatheWay: [
//                "상체를 한쪽으로 돌릴 때 숨을 내쉬고",
//                "중앙으로 돌아올 때 숨을 들이마십니다."
//            ],
//            caution: [
//                "허리에 무리가 가지 않도록 상체를 너무 많이 뒤로 기울이지 않고",
//                "동작을 천천히 제어하여 안정적으로 수행하세요."
//            ],
//            pickleImage: [
//                DSKitAsset.Assets.posturePickleTest1.image,
//                DSKitAsset.Assets.posturePickleTest2.image,
//                DSKitAsset.Assets.posturePickleTest3.image,
//                DSKitAsset.Assets.posturePickleTest4.image,
//            ]
//            )
//        )
//    }
//}
