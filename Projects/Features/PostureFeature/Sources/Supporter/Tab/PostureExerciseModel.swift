import UIKit

import SnapKit
import Then

import DSKit

public struct PostureExercise {
    var image: UIImage
    var name: String
}

public enum PostureExerciseModel {
    case chest
    case chestBody
    case chestMachine
    case back
    case backBody
    case backMachine

    var data: [PostureExercise] {
        switch self {
        case .chest:
            return [
                PostureExercise(image: DSKitAsset.Assets.benchPress.image, name: "벤치프레스"),
                PostureExercise(image: DSKitAsset.Assets.deeps.image, name: "딥스"),
                PostureExercise(image: DSKitAsset.Assets.inclineBenchPress.image, name: "인클라인 벤치프레스"),
                PostureExercise(image: DSKitAsset.Assets.pushUp.image, name: "푸시업"),
                PostureExercise(image: DSKitAsset.Assets.dumbelBenchPress.image, name: "덤벨 벤치프레스"),
                PostureExercise(image: DSKitAsset.Assets.hinduPushUp.image, name: "힌두 푸시업"),
                PostureExercise(image: DSKitAsset.Assets.weightDeeps.image, name: "중량 딥스"),
                PostureExercise(image: DSKitAsset.Assets.archPushUp.image, name: "아치 푸시업"),
                PostureExercise(image: DSKitAsset.Assets.inclineDumbelBenchPress.image, name: "인클라인 덤벨 벤치프레스"),
                PostureExercise(image: DSKitAsset.Assets.closeGripPushUp.image, name: "클로즈그립 푸시업"),
                PostureExercise(image: DSKitAsset.Assets.dumbelSqzPress.image, name: "덤벨 스퀴즈 프레스"),
                PostureExercise(image: DSKitAsset.Assets.clapPushUp.image, name: "클랩 푸시업"),
            ]
            
        case .chestBody:
            return [
                PostureExercise(image: DSKitAsset.Assets.deeps.image, name: "딥스"),
                PostureExercise(image: DSKitAsset.Assets.pushUp.image, name: "푸시업"),
                PostureExercise(image: DSKitAsset.Assets.hinduPushUp.image, name: "힌두 푸시업"),
                PostureExercise(image: DSKitAsset.Assets.archPushUp.image, name: "아치 푸시업"),
                PostureExercise(image: DSKitAsset.Assets.closeGripPushUp.image, name: "클로즈그립 푸시업"),
                PostureExercise(image: DSKitAsset.Assets.clapPushUp.image, name: "클랩 푸시업"),
            ]
        case .chestMachine:
            return [
                PostureExercise(image: DSKitAsset.Assets.benchPress.image, name: "벤치프레스"),
                PostureExercise(image: DSKitAsset.Assets.inclineBenchPress.image, name: "인클라인 벤치프레스"),
                PostureExercise(image: DSKitAsset.Assets.dumbelBenchPress.image, name: "덤벨 벤치프레스"),
                PostureExercise(image: DSKitAsset.Assets.weightDeeps.image, name: "중량 딥스"),
                PostureExercise(image: DSKitAsset.Assets.inclineDumbelBenchPress.image, name: "인클라인 덤벨 벤치프레스"),
                PostureExercise(image: DSKitAsset.Assets.dumbelSqzPress.image, name: "덤벨 스퀴즈 프레스"),
            ]
        case .back:
            return [
                PostureExercise(image: DSKitAsset.Assets.goodMorningExercise.image, name: "굿모닝 엑서사이즈"),
                PostureExercise(image: DSKitAsset.Assets.pullUp.image, name: "풀업"),
                PostureExercise(image: DSKitAsset.Assets.babelLow.image, name: "바벨 로우"),
                PostureExercise(image: DSKitAsset.Assets.invertedLow.image, name: "인버티드 로우"),
                PostureExercise(image: DSKitAsset.Assets.inclineDumbelLow.image, name: "인클라인 덤벨 로우"),
                PostureExercise(image: DSKitAsset.Assets.hyperExtension.image, name: "하이퍼 익스텐션"),
                PostureExercise(image: DSKitAsset.Assets.dumbelLow.image, name: "덤벨 로우"),
                PostureExercise(image: DSKitAsset.Assets.backExtension.image, name: "백 익스텐션"),
                PostureExercise(image: DSKitAsset.Assets.ratPullDown.image, name: "랫풀다운"),
            ]
        case .backBody:
            return [
                PostureExercise(image: DSKitAsset.Assets.pullUp.image, name: "풀업"),
                PostureExercise(image: DSKitAsset.Assets.invertedLow.image, name: "인버티드 로우"),
                PostureExercise(image: DSKitAsset.Assets.hyperExtension.image, name: "하이퍼 익스텐션"),
                PostureExercise(image: DSKitAsset.Assets.backExtension.image, name: "백 익스텐션"),
            ]
        case .backMachine:
            return [
                PostureExercise(image: DSKitAsset.Assets.goodMorningExercise.image, name: "굿모닝 엑서사이즈"),
                PostureExercise(image: DSKitAsset.Assets.babelLow.image, name: "바벨 로우"),
                PostureExercise(image: DSKitAsset.Assets.inclineDumbelLow.image, name: "인클라인 덤벨 로우"),
                PostureExercise(image: DSKitAsset.Assets.dumbelLow.image, name: "덤벨 로우"),
                PostureExercise(image: DSKitAsset.Assets.ratPullDown.image, name: "랫풀다운"),
            ]
        }
    }
}
