import UIKit

import DSKit

public struct SelfCareMyRoutineDetail {
    var image: UIImage
    var name: String
    var routine: String
}

public enum SelfCareMyRoutineDetailModel {
    case detailData

    var data: [SelfCareMyRoutineDetail] {
        switch self {
        case .detailData:
            return [
                SelfCareMyRoutineDetail(image: DSKitAsset.Assets.pushUp.image,
                                        name: "푸시업",
                                        routine: "10개 | 4세트"),
                SelfCareMyRoutineDetail(image: DSKitAsset.Assets.jumpSqt.image,
                                        name: "점프 스쿼트",
                                        routine: "20개 | 3세트"),
                SelfCareMyRoutineDetail(image: DSKitAsset.Assets.dumbelSplitSqt.image,
                                        name: "덤벨 스플릿 스쿼트",
                                        routine: "30개 | 1세트"),
                SelfCareMyRoutineDetail(image: DSKitAsset.Assets.dumbelLow.image,
                                        name: "ㅁㄴㅇㄹ",
                                        routine: "10개 | 4세트"),
                SelfCareMyRoutineDetail(image: DSKitAsset.Assets.dumbelSqzPress.image,
                                        name: "ㅁㄴㅇㄹ",
                                        routine: "10개 | 4세트"),
                SelfCareMyRoutineDetail(image: DSKitAsset.Assets.dumbelGoblinSqt.image,
                                        name: "ㅁㅇㄹ",
                                        routine: "10개 | 4세트"),
                SelfCareMyRoutineDetail(image: DSKitAsset.Assets.inclineDumbelLow.image,
                                        name: "ㅁㅇㄹㅁㄴㅇㄹ",
                                        routine: "10개 | 4세트"),
                SelfCareMyRoutineDetail(image: DSKitAsset.Assets.deeps.image,
                                        name: "ㅁㅇㄴㄹㅁㅇㄴㄹ ㅁㅇㄴㄹ",
                                        routine: "10개 | 4세트"),
                SelfCareMyRoutineDetail(image: DSKitAsset.Assets.weightDeeps.image,
                                        name: "ㅁㅇㄹ",
                                        routine: "10개 | 4세트"),
                SelfCareMyRoutineDetail(image: DSKitAsset.Assets.benchPress.image,
                                        name: "ㅁㅇㄹ",
                                        routine: "10개 | 4세트")

            ]
        }
    }
}
