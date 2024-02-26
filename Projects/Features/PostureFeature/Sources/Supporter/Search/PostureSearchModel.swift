import UIKit

import DSKit
import MGNetworks

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
                SearchElement(image: PostureResourcesService.Assets.postureChestTest6, exerciseName: "바벨 백스쿼트", exercisePart: "하체"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest7, exerciseName: "바벨 불가리안 스플릿 스쿼트", exercisePart: "하체"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest2, exerciseName: "바벨 힙 쓰러스트", exercisePart: "하체"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest3, exerciseName: "점프 스쿼트", exercisePart: "등"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest5, exerciseName: "인클라인 바벨 로우", exercisePart: "등"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest6, exerciseName: "바벨 백스쿼트", exercisePart: "하체"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest7, exerciseName: "바벨 불가리안 스플릿 스쿼트", exercisePart: "하체"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest2, exerciseName: "바벨 힙 쓰러스트", exercisePart: "하체"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest3, exerciseName: "점프 스쿼트", exercisePart: "등"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest5, exerciseName: "인클라인 바벨 로우", exercisePart: "등")
                
            ]
        case .second:
            return [
                SearchElement(image: PostureResourcesService.Assets.postureChestTest6, exerciseName: "바벨 컬", exercisePart: "필"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest7, exerciseName: "덤벨 컬", exercisePart: "필"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest2, exerciseName: "이지바 컬", exercisePart: "팔"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest3, exerciseName: "덤벨 헤머 컬", exercisePart: "팔"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest5, exerciseName: "C컬", exercisePart: "팔"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest6, exerciseName: "바벨 백스쿼트", exercisePart: "하체"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest7, exerciseName: "바벨 불가리안 스플릿 스쿼트", exercisePart: "하체"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest2, exerciseName: "바벨 힙 쓰러스트", exercisePart: "하체"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest3, exerciseName: "점프 스쿼트", exercisePart: "등"),
                SearchElement(image: PostureResourcesService.Assets.postureChestTest5, exerciseName: "인클라인 바벨 로우", exercisePart: "등")
            ]
        }
    }

    
}
