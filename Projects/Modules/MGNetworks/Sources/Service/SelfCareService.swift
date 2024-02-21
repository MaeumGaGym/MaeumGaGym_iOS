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

    public init() {

    }
}

