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

    public init() {

    }
}

