//
//  SettingViewModel.swift
//  RxFlowTest
//
//  Created by 박준하 on 2/27/24.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import Core

enum SettingActionType {
    case nextScreen(step: TetstMainSteps)
    case previousScreen(step: TetstMainSteps)
    case toast
    case dismiss
}

public class SettingViewModel: Stepper, BaseViewModel {

    public typealias ViewModel = SettingViewModel

    public struct Input {
        let actionTrigger: Observable<SettingActionType>
    }

    public struct Output {

    }

    var disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()

    public var initialStep: Step {
        return TetstMainSteps.initialization
    }

    public func transform(_ input: Input, action: (Output) -> Void) -> Output {
        input.actionTrigger.bind(onNext: runAction).disposed(by: disposeBag)
        return Output()
    }
}

extension SettingViewModel {
    /// 각 Setting Action에 맞게 로직을 처리하도록 연결해주는 메소드
    private func runAction(_ actionType: SettingActionType) {
        switch actionType {
        case .nextScreen(let step):
            moveToNextPage(step: step)
        case .previousScreen(let step):
            moveToPreviousPage(step: step)
        case .toast:
            showToast()
        case .dismiss:
            dismissToast()
        }
    }

    private func moveToNextPage(step: TetstMainSteps) {
        steps.accept(step)
    }

    private func moveToPreviousPage(step: TetstMainSteps) {
        steps.accept(step)
    }

    private func showToast() {
        steps.accept(TetstMainSteps.modalRequired)
    }

    private func dismissToast() {
        steps.accept(TetstMainSteps.dismiss)
    }
}
