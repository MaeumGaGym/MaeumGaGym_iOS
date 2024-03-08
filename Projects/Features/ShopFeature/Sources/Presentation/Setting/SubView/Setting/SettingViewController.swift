//
//  SettingViewController.swift
//  RxFlowTest
//
//  Created by 박준하 on 2/27/24.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

import Core

class SettingViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = SettingViewModel

    var viewModel: ViewModel!

    var disposeBag = DisposeBag()
    var actionTrigger = PublishRelay<SettingActionType>()

    lazy var settingView = SettingView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        bind()
    }

    private func bind() {
        _ = viewModel.transform(ViewModel.Input(actionTrigger: actionTrigger.asObservable()), action: { _ in 
            
        })

        settingView.setupDI(observable: actionTrigger)
    }

    private func setupLayout() {
        view.addSubview(settingView)

        settingView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
