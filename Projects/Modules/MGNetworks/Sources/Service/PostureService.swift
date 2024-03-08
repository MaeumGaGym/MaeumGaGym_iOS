import UIKit

import RxSwift

import Domain
import DSKit

public class PostureService {
    public func requestRecommandData() ->
    Single<[PostureRecommandModel]> {
        let postureRecommandData: [PostureRecommandModel] = [
            PostureRecommandModel(
                titleImage: PostureResourcesService.Assets.blueArmIcon,
                titleText: PostureResourcesService.Title.postureBodyTitle,
                exerciseData: [
                    PostureRecommandExerciseModel(image: PostureResourcesService.Assets.pushUp, name: "푸시업", part: "가슴"),
                    PostureRecommandExerciseModel(image: PostureResourcesService.Assets.bodySplitSqt, name: "맨몸 스플릿 스쿼트", part: "하체"),
                    PostureRecommandExerciseModel(image: PostureResourcesService.Assets.backExtension, name: "백 익스텐션", part: "등")
                ]
            ),
            PostureRecommandModel(
                titleImage: PostureResourcesService.Assets.blueDumbelIcon,
                titleText: PostureResourcesService.Title.postureMachineTitle,
                exerciseData: [
                    PostureRecommandExerciseModel(image: PostureResourcesService.Assets.deeps, name: "딥스", part: "가슴"),
                    PostureRecommandExerciseModel(image: PostureResourcesService.Assets.benchPress, name: "벤치프레스", part: "가슴"),
                    PostureRecommandExerciseModel(image: PostureResourcesService.Assets.runge, name: "런지", part: "하체")
                ]
            )
        ]
        return Single.just(postureRecommandData)
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

    public func requestDetailData(type: PostureDetailType) -> Single<PostureDetailModel> {
        switch type {
        case .pushUp:
            return requestPushUpData()
        }
    }

    public func requestSearchData() -> Single<PostureSearchModel> {
        return.just(
            PostureSearchModel(
                searchResultData: [
                    PostureSearchContentModel(exerciseImage: PostureResourcesService.Assets.airSqt,
                                              exerciseName: "에어 스쿼트", exercisePart: "하체"),
                    PostureSearchContentModel(exerciseImage: PostureResourcesService.Assets.archPushUp,
                                              exerciseName: "아치 푸시업", exercisePart: "하체"),
                    PostureSearchContentModel(exerciseImage: PostureResourcesService.Assets.babelLow,
                                              exerciseName: "바벨 로우", exercisePart: "팔"),
                    PostureSearchContentModel(exerciseImage: PostureResourcesService.Assets.babelBackSqt,
                                              exerciseName: "바벨 백 스쿼트", exercisePart: "하체"),
                    PostureSearchContentModel(exerciseImage: PostureResourcesService.Assets.babelBgrSplitSqt,
                                              exerciseName: "바벨 불가리안 스플릿 스쿼트", exercisePart: "하체"),
                    PostureSearchContentModel(exerciseImage: PostureResourcesService.Assets.bodySplitSqt,
                                              exerciseName: "바디 스플릿 스쿼트", exercisePart: "하체"),
                    PostureSearchContentModel(exerciseImage: PostureResourcesService.Assets.clapPushUp,
                                              exerciseName: "클랩 푸시업", exercisePart: "가슴"),
                    PostureSearchContentModel(exerciseImage: PostureResourcesService.Assets.invertedLow,
                                              exerciseName: "인버티드 로우", exercisePart: "하체"),
                    PostureSearchContentModel(exerciseImage: PostureResourcesService.Assets.pullUp,
                                              exerciseName: "풀업", exercisePart: "등"),
                    PostureSearchContentModel(exerciseImage: PostureResourcesService.Assets.weightDeeps,
                                              exerciseName: "중량 딥스", exercisePart: "가슴"),
                ]
            )
        )
    }

    public init() {

    }
}

private extension PostureService {
    func requestChestData() ->
    Single<PosturePartModel> {
        return Single.just(
            PosturePartModel(
                exerciseType: [
                    PosturePartExerciseTypeModel(
                        exerciseName: PostureResourcesService.Title.bodyTitle),
                    PosturePartExerciseTypeModel(
                        exerciseName: PostureResourcesService.Title.machineTitle)
                ],
                allExerciseData: [
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.benchPress, name: "벤치프레스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.deeps, name: "딥스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.inclineBenchPress, name: "인클라인 벤치프레스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.pushUp, name: "푸시업"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.dumbelBenchPress, name: "덤벨 벤치프레스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.hinduPushUp, name: "힌두 푸시업"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.weightDeeps, name: "중량 딥스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.archPushUp, name: "아치 푸시업"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.inclineDumbelBenchPress, name: "인클라인 덤벨 벤치프레스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.closeGripPushUp, name: "클로즈그립 푸시업"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.dumbelSqzPress, name: "덤벨 스퀴즈 프레스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.clapPushUp, name: "클랩 푸시업"),
                ],
                bodyExerciseData: [
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.deeps, name: "딥스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.pushUp, name: "푸시업"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.hinduPushUp, name: "힌두 푸시업"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.archPushUp, name: "아치 푸시업"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.closeGripPushUp, name: "클로즈그립 푸시업"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.clapPushUp, name: "클랩 푸시업"),
                ],
                machineExerciseData: [
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.benchPress, name: "벤치프레스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.inclineBenchPress, name: "인클라인 벤치프레스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.dumbelBenchPress, name: "덤벨 벤치프레스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.weightDeeps, name: "중량 딥스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.inclineDumbelBenchPress, name: "인클라인 덤벨 벤치프레스"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.dumbelSqzPress, name: "덤벨 스퀴즈 프레스"),
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
                        exerciseName: PostureResourcesService.Title.bodyTitle),
                    PosturePartExerciseTypeModel(
                        exerciseName: PostureResourcesService.Title.machineTitle)
                ],
                allExerciseData: [
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.goodMorningExercise, name: "굿모닝 엑서사이즈"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.pullUp, name: "풀업"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.babelLow, name: "바벨 로우"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.invertedLow, name: "인버티드 로우"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.inclineDumbelLow, name: "인클라인 덤벨 로우"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.hyperExtension, name: "하이퍼 익스텐션"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.dumbelLow, name: "덤벨 로우"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.backExtension, name: "백 익스텐션"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.ratPullDown, name: "랫풀다운")
                ],
                bodyExerciseData: [
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.pullUp, name: "풀업"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.invertedLow, name: "인버티드 로우"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.backExtension, name: "하이퍼 익스텐션"),
                    PosturePartExerciseModel(image: DSKitAsset.Assets.backExtension.image, name: "백 익스텐션")
                ],
                machineExerciseData: [
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.goodMorningExercise, name: "굿모닝 엑서사이즈"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.babelLow, name: "바벨 로우"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.inclineDumbelLow, name: "인클라인 덤벨 로우"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.dumbelLow, name: "덤벨 로우"),
                    PosturePartExerciseModel(image: PostureResourcesService.Assets.ratPullDown, name: "랫풀다운"),
                ]
            )
        )
    }
}

private extension PostureService {
    func requestPushUpData() -> Single<PostureDetailModel>{
        return Single.just(
            PostureDetailModel(
                detailImage: PostureResourcesService.Assets.pushUp,
                titleTextData: PostureDetailTitleTextModel(englishName: "푸쉬업", koreanName: "팔굽혀펴기"),
                exerciseKindData: [PostureDetailExerciseKindModel(exerciseTag: "맨몸"),
                                   PostureDetailExerciseKindModel(exerciseTag: "가슴")],
                exerciseWayData:
                    PostureDetailInfoModel(
                        titleText: PostureResourcesService.Title.execiseWayTitle,
                        infoText:
                    [
                        PostureDetailInfoTextModel(text: "양팔을 가슴 옆에 두고 바닥에 엎드립니다."),
                        PostureDetailInfoTextModel(text: "복근과 둔근에 힘을 준 상태로 팔꿈치를 피며\n올라옵니다."),
                        PostureDetailInfoTextModel(text: "천천히 팔꿈치를 굽히며 시작 자세로 돌아갑니다."),
                        PostureDetailInfoTextModel(text: "양팔을 가슴 옆에 두고 바닥에 엎드립니다."),
                        PostureDetailInfoTextModel(text: "양팔을 가슴 옆에 두고 바닥에 엎드립니다.")
                    ]),
                exerciseCautionData:
                    PostureDetailInfoModel(
                        titleText: PostureResourcesService.Title.cautionTitle,
                        infoText:
                    [
                        PostureDetailInfoTextModel(text: "양팔을 가슴 옆에 두고 바닥에 엎드립니다."),
                        PostureDetailInfoTextModel(text: "복근과 둔근에 힘을 준 상태로 팔꿈치를 피며\n올라옵니다.")
                    ]),
                relatedPickleData:
                    PostureDetailPickleModel(
                        titleText: PostureResourcesService.Title.relatedPickleTitle,
                        pickleImage: [
                        PostureDetailPickleImageModel(image: PostureResourcesService.Assets.posturePickleTest1),
                        PostureDetailPickleImageModel(image: PostureResourcesService.Assets.posturePickleTest2),
                        PostureDetailPickleImageModel(image: PostureResourcesService.Assets.posturePickleTest3),
                        PostureDetailPickleImageModel(image: PostureResourcesService.Assets.posturePickleTest4),
                    ])
            )
        )
    }
}
