import UIKit

import RxSwift
import RxCocoa

import RxMoya
import Moya

import DSKit
import Domain
import TokenManager

import MGLogger

public protocol SelfCareService {
    func getMyRoutineData() -> Single<SelfCareMyRoutineModel>
    func getMyRoutineDetailData() -> Single<SelfCareMyRoutineDetailModel>
    func getMyRoutineEditData() -> Single<SelfCareMyRoutineEditModel>
    //MARK: Target
    func getMyTarget(accessToken: String, page: Int) -> Single<Response>
    func getMonthTarget(accessToken: String, date: String) -> Single<Response>
    func getDetailTarget(accessToken: String, id: Int) -> Single<Response>
    func addTarget(accessToken: String, title: String, content: String, startDate: String, endDate: String) -> Single<Response>
    func modifyTarget(accessToken: String, title: String, content: String, startDate: String, endDate: String, id: Int) -> Single<Response>
    func deleteTarget(accessToken: String, id: Int) -> Single<Response>

    //MARK: Profile
    func getProfileData(accessToken: String, userName: String) -> Single<Response>
    func requestProfileModify(accessToken: String, nickName: String, height: Double, weight: Double, gender: String) -> Single<Response>
    func requestProfileInfo(accessToken: String) -> Single<Response>
    func requestUserDel(accessToken: String) -> Single<Response>
}

public class DefaultSelfCareService: NSObject {
    let routineProvider = MoyaProvider<RoutineAPI>(plugins: [MoyaLoggingPlugin()])
    let targetProvider = MoyaProvider<TargetAPI>(plugins: [MoyaLoggingPlugin()])
    let profileProvider = MoyaProvider<ProfileAPI>(plugins: [MoyaLoggingPlugin()])
    let authProvider = MoyaProvider<AuthAPI>()
}

extension DefaultSelfCareService: SelfCareService {
    public func requestProfileInfo(accessToken: String) -> Single<Response> {
        return profileProvider.rx.request(.profileInfoShow(accessToken: accessToken)).filterSuccessfulStatusCodes()
    }
    

    public func getMyRoutineData() ->
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

    public func getMyRoutineDetailData() -> Single<SelfCareMyRoutineDetailModel> {
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

    public func getMyRoutineEditData() -> Single<SelfCareMyRoutineEditModel> {
        return Single.just(
            SelfCareMyRoutineEditModel(
                textFieldData: MyRoutineEditTextFieldModel(
                    textFieldTitle: "제목", 
                    textFieldText: "주말 루틴",
                    textFieldPlaceholder: "제목을 입력해주세요."), date: [],
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

//    public func getMyRoutineData(accessToken: String) -> Single<Response> {
//        return routineProvider.rx.request(.routineMyAll(accessToken: accessToken))
//            .filterSuccessfulStatusCodes()
//    }
//    public func getMyRoutineDetailData() -> Single<Response> {
//        return routineProvider.rx.request(.rou)
//    }
//    public func getMyRoutineEditData() -> Single<Response> {
//
//    }

    public func getMyTarget(accessToken: String, page: Int) -> Single<Response> {
        return targetProvider.rx.request(.getMyTarget(accessToken: accessToken, page: page))
            .filterSuccessfulStatusCodes()
    }
    public func getMonthTarget(accessToken: String, date: String) -> Single<Response> {
        return targetProvider.rx.request(.getMonthTarget(accessToken: accessToken, date: date))
            .filterSuccessfulStatusCodes()
    }
    public func getDetailTarget(accessToken: String, id: Int) -> Single<Response> {
        return targetProvider.rx.request(.getTarget(accessToken: accessToken, id: id))
            .filterSuccessfulStatusCodes()
    }
    public func addTarget(accessToken: String, title: String, content: String, startDate: String, endDate: String) -> Single<Response> {
        return targetProvider.rx.request(.targetAdd(accessToken: accessToken, title: title, content: content, startDate: startDate, endDate: endDate))
            .filterSuccessfulStatusCodes()
    }
    public func modifyTarget(accessToken: String, title: String, content: String, startDate: String, endDate: String, id: Int) -> Single<Response> {
        return targetProvider.rx.request(.targetEdit(accessToken: accessToken, title: title, content: content, startDate: startDate, endDate: endDate, id: id))
            .filterSuccessfulStatusCodes()
    }
    public func deleteTarget(accessToken: String, id: Int) -> Single<Response> {
        return targetProvider.rx.request(.targetDelete(accessToken: accessToken, id: id))
            .filterSuccessfulStatusCodes()
    }
    
    public func getProfileData(accessToken: String, userName: String) -> Single<Response> {
        return profileProvider.rx.request(.profileCheck(accessToken: accessToken, userName: userName))
            .filterSuccessfulStatusCodes()
    }
    
    public func requestProfileModify(accessToken: String, nickName: String, height: Double, weight: Double, gender: String) -> Single<Response> {
        return profileProvider.rx.request(.profileInfoModify(accessToken: accessToken, nickName: nickName, height: height, weight: weight, gender: gender))
            .filterSuccessfulStatusCodes()
    }
    
    public func requestUserDel(accessToken: String) -> Single<Response> {
        return authProvider.rx.request(.delete(accessToken: accessToken)).filterSuccessfulStatusCodes()
    }
}

