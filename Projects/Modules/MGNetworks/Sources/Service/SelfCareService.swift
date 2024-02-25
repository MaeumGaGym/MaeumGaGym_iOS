import UIKit

import RxSwift

import Domain
import DSKit

public class SelfCareService {

    public func requestMyRoutineData() ->
    Single<SelfCareMyRoutineModel> {
        return Single.just(
            SelfCareMyRoutineModel(
                titleTextData:
                    SelfCareMyRoutineTextModel(
                        titleText: "내 루틴",
                        infoText: "나만의 루틴을 구성하여\n규칙적인 운동을 해보세요."
                    ),
                myRoutineData: [
                    SelfCareRoutineModel(
                        routineNameText: "주말 루틴",
                        usingState: true,
                        sharingState: true
                    ),
                    SelfCareRoutineModel(
                        routineNameText: "평일 루틴",
                        usingState: false,
                        sharingState: false
                    ),
                    SelfCareRoutineModel(
                        routineNameText: "주말 루틴",
                        usingState: true,
                        sharingState: true
                    ),
                    SelfCareRoutineModel(
                        routineNameText: "주말 루틴",
                        usingState: true,
                        sharingState: true
                    ),
                    SelfCareRoutineModel(
                        routineNameText: "주말 루틴",
                        usingState: true,
                        sharingState: true
                    ),
                    SelfCareRoutineModel(
                        routineNameText: "주말 루틴",
                        usingState: true,
                        sharingState: true
                    ),
                    SelfCareRoutineModel(
                        routineNameText: "주말 루틴",
                        usingState: true,
                        sharingState: true
                    ),
                    SelfCareRoutineModel(
                        routineNameText: "주말 루틴",
                        usingState: true,
                        sharingState: true
                    ),
                    SelfCareRoutineModel(
                        routineNameText: "주말 루틴",
                        usingState: true,
                        sharingState: true
                    ),
                ]
            )
        )
    }

    public func requestMyRoutineDetailData() -> Single<SelfCareMyRoutineDetailModel> {
        return Single.just(
            SelfCareMyRoutineDetailModel(
                routineTitleData: SelfCareRoutineModel(
                    routineNameText: "주말 루틴",
                    usingState: true,
                    sharingState: true),
                routinesData: [
                    SelfCareMyRoutineDetailExerciseModel(
                        exericseImage: DSKitAsset.Assets.pushUp.image,
                        exerciseTitle: "푸쉬업",
                        exerciseCount: 10,
                        exerciseSet: 4
                    ),
                    SelfCareMyRoutineDetailExerciseModel(
                        exericseImage: DSKitAsset.Assets.ratPullDown.image,
                        exerciseTitle: "랫풀다운",
                        exerciseCount: 20,
                        exerciseSet: 4
                    ),
                    SelfCareMyRoutineDetailExerciseModel(
                        exericseImage: DSKitAsset.Assets.babelBackSqt.image,
                        exerciseTitle: "바밸 백스쿼트",
                        exerciseCount: 20,
                        exerciseSet: 3
                    ),
                ]
            )
        )
    }

    public func requestMyRoutineEditData() -> Single<SelfCareMyRoutineEditModel> {
        return Single.just(
            SelfCareMyRoutineEditModel(
                textFieldData: MyRoutineEditTextFieldModel(
                    textFieldTitle: "제목", 
                    textFieldText: "주말 루틴",
                    textFieldPlaceholder: "제목을 입력해주세요."),
                exerciseData: [
                    MyRoutineEditExerciseModel(
                        exerciseImage: DSKitAsset.Assets.pushUp.image,
                        exerciseName: "푸쉬업",
                        textFieldData: [
                            MyRouinteEditExerciseTextFieldModel(
                                textFieldTitle: "횟수",
                                exerciseCount: 10),
                            MyRouinteEditExerciseTextFieldModel(
                                textFieldTitle: "세트",
                                exerciseCount: 4)
                        ]
                    ),
                    MyRoutineEditExerciseModel(
                        exerciseImage: DSKitAsset.Assets.deeps.image,
                        exerciseName: "딥스",
                        textFieldData: [
                            MyRouinteEditExerciseTextFieldModel(
                                textFieldTitle: "횟수",
                                exerciseCount: 10),
                            MyRouinteEditExerciseTextFieldModel(
                                textFieldTitle: "세트",
                                exerciseCount: 3)
                        ]
                    ),
                    MyRoutineEditExerciseModel(
                        exerciseImage: DSKitAsset.Assets.jumpSqt.image,
                        exerciseName: "점프 스쿼트",
                        textFieldData: [
                            MyRouinteEditExerciseTextFieldModel(
                                textFieldTitle: "횟수",
                                exerciseCount: 20),
                            MyRouinteEditExerciseTextFieldModel(
                                textFieldTitle: "세트",
                                exerciseCount: 3)
                        ]
                    )
                ]
            )
        )
    }

    public func requestTargetMainData() -> Single<SelfCareTargetMainModel> {
        return Single.just(SelfCareTargetMainModel(
            titleTextData:
                TargetTitleTextModel(
                    titleText: "목표",
                    infoText: "나만의 목표를 세워보세요."
                ),
            targetData: [
                TargetContentModel(
                    targetTitle: "디자인 완성하기",
                    targetStartData: "12월 17일",
                    targetEndData: "12월 18일"),
                TargetContentModel(
                    targetTitle: "공부하기",
                    targetStartData: "12월 17일",
                    targetEndData: "2024년 01월 28일"),
                ]
            )
        )
    }

    public init() {

    }
}

