import UIKit

import DSKit

public struct SearchElement {
    public var image: UIImage
    public var exerciseName: String
    public var exercisePart: String
}

public enum PostureSearchModel {
    case first
    case second
    
    public var data: [SearchElement] {
        switch self {
        case .first:
            return [
                SearchElement(image: DSKitAsset.Assets.postureChestTest6.image, exerciseName: "바벨 백스쿼트", exercisePart: "하체"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest7.image, exerciseName: "바벨 불가리안 스플릿 스쿼트", exercisePart: "하체"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest2.image, exerciseName: "바벨 힙 쓰러스트", exercisePart: "하체"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest3.image, exerciseName: "점프 스쿼트", exercisePart: "등"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest5.image, exerciseName: "인클라인 바벨 로우", exercisePart: "등"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest6.image, exerciseName: "바벨 백스쿼트", exercisePart: "하체"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest7.image, exerciseName: "바벨 불가리안 스플릿 스쿼트", exercisePart: "하체"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest2.image, exerciseName: "바벨 힙 쓰러스트", exercisePart: "하체"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest3.image, exerciseName: "점프 스쿼트", exercisePart: "등"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest5.image, exerciseName: "인클라인 바벨 로우", exercisePart: "등")
                
            ]
        case .second:
            return [
                SearchElement(image: DSKitAsset.Assets.postureChestTest6.image, exerciseName: "바벨 컬", exercisePart: "필"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest7.image, exerciseName: "덤벨 컬", exercisePart: "필"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest2.image, exerciseName: "이지바 컬", exercisePart: "팔"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest3.image, exerciseName: "덤벨 헤머 컬", exercisePart: "팔"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest5.image, exerciseName: "C컬", exercisePart: "팔"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest6.image, exerciseName: "바벨 백스쿼트", exercisePart: "하체"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest7.image, exerciseName: "바벨 불가리안 스플릿 스쿼트", exercisePart: "하체"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest2.image, exerciseName: "바벨 힙 쓰러스트", exercisePart: "하체"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest3.image, exerciseName: "점프 스쿼트", exercisePart: "등"),
                SearchElement(image: DSKitAsset.Assets.postureChestTest5.image, exerciseName: "인클라인 바벨 로우", exercisePart: "등")
            ]
        }
    }

    
}
